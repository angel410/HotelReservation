using HotelReservation.Core.Entities;
using HotelReservation.Core.Interfaces;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HotelReservation.Infrastructure.Data
{
    public class ReservationRepository : IReservationRepository
    {
        private readonly HotelReservationContext _context;

        public ReservationRepository(HotelReservationContext context)
        {
            _context = context;
        }

        // Get all reservations for a specific user
        public async Task<IEnumerable<Reservation>> GetUserReservationsAsync(int userId)
        {
            return await _context.Reservations
                .Where(r => r.UserId == userId)
                .Include(r => r.Room)
                .ToListAsync();
        }

        // Get a specific reservation by its ID
        public async Task<Reservation> GetReservationByIdAsync(int reservationId)
        {
            return await _context.Reservations
                .Include(r => r.Room)
                .FirstOrDefaultAsync(r => r.ReservationId == reservationId);
        }

        // Add a new reservation
        public async Task AddReservationAsync(Reservation reservation)
        {
            _context.Reservations.Add(reservation);

            var room = await _context.Rooms.FindAsync(reservation.RoomId);
            if (room != null)
            {
                room.IsAvailable = false;
                _context.Rooms.Update(room);
            }

            await _context.SaveChangesAsync();
        }

        // Update an existing reservation
        public async Task UpdateReservationAsync(Reservation updatedReservation)
        {
            var originalReservation = await _context.Reservations
                .AsNoTracking()
                .FirstOrDefaultAsync(r => r.ReservationId == updatedReservation.ReservationId);

            if (originalReservation == null)
            {
                throw new Exception("Reservation not found.");
            }

            if (originalReservation.RoomId != updatedReservation.RoomId)
            {
                var oldRoom = await _context.Rooms.FindAsync(originalReservation.RoomId);
                if (oldRoom != null)
                {
                    oldRoom.IsAvailable = true;
                    _context.Rooms.Update(oldRoom);
                }

                var newRoom = await _context.Rooms.FindAsync(updatedReservation.RoomId);
                if (newRoom != null)
                {
                    newRoom.IsAvailable = false;
                    _context.Rooms.Update(newRoom);
                }
            }

            _context.Reservations.Update(updatedReservation);

            await _context.SaveChangesAsync();
        }

        // Delete a reservation by its ID
        public async Task DeleteReservationAsync(int reservationId)
        {
            var reservation = await GetReservationByIdAsync(reservationId);
            if (reservation != null)
            {
                var room = await _context.Rooms.FindAsync(reservation.RoomId);
                if (room != null)
                {
                    room.IsAvailable = true;
                    _context.Rooms.Update(room);
                }

                _context.Reservations.Remove(reservation);

                await _context.SaveChangesAsync();
            }
        }

        public async Task<IEnumerable<Reservation>> GetReservationsForRoomAsync(int roomId, DateTime checkInDate, DateTime checkOutDate)
        {
            return await _context.Reservations
                .Where(r => r.RoomId == roomId &&
                            EF.Functions.DateDiffDay(r.CheckInDate, checkOutDate.Date) >= 0 &&
                            EF.Functions.DateDiffDay(r.CheckOutDate, checkInDate.Date) <= 0)
                .ToListAsync();
        }
    }
}
