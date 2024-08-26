using HotelReservation.Core.Entities;
using HotelReservation.Core.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HotelReservation.Infrastructure.Data
{
    public class RoomRepository : IRoomRepository
    {
        private readonly HotelReservationContext _context;

        public RoomRepository(HotelReservationContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<Room>> GetAvailableRoomsAsync()
        {
            return await _context.Rooms.Where(r => r.IsAvailable).ToListAsync();
        }

        public async Task<Room> GetRoomByIdAsync(int roomId)
        {
            return await _context.Rooms.FindAsync(roomId);
        }
    }
}
