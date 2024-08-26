using HotelReservation.Core.Entities;
using HotelReservation.Core.Interfaces;


namespace HotelReservation.Application.Services
{
    public class ReservationService
    {
        private readonly IReservationRepository _reservationRepository;
        private readonly IRoomRepository _roomRepository;

        public ReservationService(IReservationRepository reservationRepository, IRoomRepository roomRepository)
        {
            _reservationRepository = reservationRepository;
            _roomRepository = roomRepository;
        }

        public async Task<Reservation> CreateReservationAsync(int userId, int roomId, DateTime checkInDate, DateTime checkOutDate)
        {
            // Check if the room exists and is available
            var room = await _roomRepository.GetRoomByIdAsync(roomId);
            if (room == null || !room.IsAvailable)
                throw new Exception("Room is not available");

            // Check if the room is already reserved during the desired period
            var existingReservations = await _reservationRepository.GetReservationsForRoomAsync(roomId, checkInDate.Date, checkOutDate.Date);
            if (existingReservations.Any())
                throw new Exception("Room is already reserved for the selected dates");

            // Create the new reservation
            var reservation = new Reservation
            {
                UserId = userId,
                RoomId = roomId,
                CheckInDate = checkInDate,
                CheckOutDate = checkOutDate
            };

            await _reservationRepository.AddReservationAsync(reservation);

            return reservation;
        }


        // Get reservations for a specific user
        public async Task<IEnumerable<Reservation>> GetUserReservationsAsync(int userId)
        {
            var reservations = await _reservationRepository.GetUserReservationsAsync(userId);
            return reservations;
        }

        public async Task<Reservation> GetReservationByIdAsync(int reservationId)
        {
            var reservation = await _reservationRepository.GetReservationByIdAsync(reservationId);
            return reservation;
        }

        // Edit an existing reservation
        public async Task<Reservation> EditReservationAsync(int reservationId, int roomId, DateTime checkInDate, DateTime checkOutDate)
        {
            var reservation = await _reservationRepository.GetReservationByIdAsync(reservationId);
            if (reservation == null)
                throw new Exception("Reservation not found");

            var room = await _roomRepository.GetRoomByIdAsync(roomId);
            if (room == null || !room.IsAvailable)
                throw new Exception("Room is not available");

            // Update the reservation details
            reservation.RoomId = roomId;
            reservation.CheckInDate = checkInDate;
            reservation.CheckOutDate = checkOutDate;

            await _reservationRepository.UpdateReservationAsync(reservation);

            return reservation;
        }

        // Delete an existing reservation
        public async Task DeleteReservationAsync(int reservationId)
        {
            var reservation = await _reservationRepository.GetReservationByIdAsync(reservationId);
            if (reservation == null)
                throw new Exception("Reservation not found");

            await _reservationRepository.DeleteReservationAsync(reservationId);
        }
    }
}
