using HotelReservation.Application.Services;
using HotelReservation.Core.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Threading.Tasks;

namespace HotelReservation.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]


    public class ReservationsController : ControllerBase
    {
        private readonly ReservationService _reservationService;

        public ReservationsController(ReservationService reservationService)
        {
            _reservationService = reservationService;
        }

        // POST: api/reservations/create
        [HttpPost("create")]
        public async Task<IActionResult> Create([FromBody] ReservationModel model)
        {
            try
            {
                // Extract the UserId from the JWT claims
                var userIdClaim = User.FindFirst("UserId")?.Value;
                if (string.IsNullOrEmpty(userIdClaim))
                {
                    return Unauthorized("User ID not found in token.");
                }
                int userId = int.Parse(userIdClaim);

                // Create a reservation using the extracted userId
                var reservation = await _reservationService.CreateReservationAsync(userId, model.RoomId, model.CheckInDate, model.CheckOutDate);
                return Ok("Reservation created successfully");
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        // GET: api/reservations/user/{userId}
        [HttpGet("user/{userId}")]
        public async Task<IActionResult> GetUserReservations(int userId)
        {
            // Ensure the user is authorized to access their own reservations
            var userIdClaim = User.FindFirst("UserId")?.Value;
            if (userIdClaim == null || int.Parse(userIdClaim) != userId)
            {
                return Unauthorized("You are not authorized to view these reservations.");
            }

            var reservations = await _reservationService.GetUserReservationsAsync(userId);
            return Ok(reservations);
        }

        // PUT: api/reservations/edit/{id}
        [HttpPut("edit/{id}")]
        public async Task<IActionResult> Edit(int id, [FromBody] ReservationModel model)
        {
            try
            {
                // Extract the UserId from the JWT claims
                var userIdClaim = User.FindFirst("UserId")?.Value;
                if (userIdClaim == null)
                {
                    return Unauthorized("User ID not found in token.");
                }

                int userId = int.Parse(userIdClaim);

                // Ensure the reservation belongs to the authenticated user before editing
                var reservation = await _reservationService.GetReservationByIdAsync(id);
                if (reservation == null)
                {
                    return NotFound("Reservation not found.");
                }

                if (reservation.UserId != userId)
                {
                    return Unauthorized("You are not authorized to edit this reservation.");
                }

                // Perform the edit operation
                await _reservationService.EditReservationAsync(id, model.RoomId, model.CheckInDate, model.CheckOutDate);
                return Ok("Reservation edited successfully");
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }


        // DELETE: api/reservations/delete/{id}
        [HttpDelete("delete/{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            try
            {
                // Extract the UserId from the JWT claims
                var userIdClaim = User.FindFirst("UserId")?.Value;
                if (userIdClaim == null)
                {
                    return Unauthorized("User ID not found in token.");
                }

                int userId = int.Parse(userIdClaim);

                // Ensure the reservation belongs to the authenticated user before deleting
                var reservation = await _reservationService.GetReservationByIdAsync(id);
                if (reservation.UserId != userId)
                {
                    return Unauthorized("You are not authorized to delete this reservation.");
                }

                await _reservationService.DeleteReservationAsync(id);
                return Ok("Reservation deleted successfully");
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}
