namespace HotelReservation.Core.Entities
{
    public class ReservationModel
    {
        //public int UserId { get; set; }
        public int RoomId { get; set; }
        public DateTime CheckInDate { get; set; }
        public DateTime CheckOutDate { get; set; }
    }

}
