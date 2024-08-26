using HotelReservation.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HotelReservation.Core.Interfaces
{
    public interface IRoomRepository
    {
        Task<IEnumerable<Room>> GetAvailableRoomsAsync();
        Task<Room> GetRoomByIdAsync(int roomId);
    }
}
