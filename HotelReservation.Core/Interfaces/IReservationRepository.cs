using HotelReservation.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HotelReservation.Core.Interfaces
{
    public interface IReservationRepository
    {
        // Add a new reservation
        Task AddReservationAsync(Reservation reservation);

        // Get all reservations for a specific user
        Task<IEnumerable<Reservation>> GetUserReservationsAsync(int userId);

        // Get a reservation by its ID
        Task<Reservation> GetReservationByIdAsync(int reservationId);

        // Update an existing reservation
        Task UpdateReservationAsync(Reservation reservation);

        // Delete a reservation by its ID
        Task DeleteReservationAsync(int reservationId);
        Task<IEnumerable<Reservation>> GetReservationsForRoomAsync(int roomId, DateTime checkInDate, DateTime checkOutDate);

    }
}
