namespace HotelReservation.Core.Entities
{
    public class EditReservationModel
    {
        public int RoomId { get; set; }
        public DateTime CheckInDate { get; set; }
        public DateTime CheckOutDate { get; set; }
    }

}
