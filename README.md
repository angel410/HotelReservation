# Hotel Reservation System

A simple hotel reservation system built with ASP.NET Core. This project provides APIs for user authentication, room reservations, and managing hotel rooms.

## Table of Contents

- [Project Overview](#project-overview)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Project Structure](#project-structure)
- [Setup and Installation](#setup-and-installation)
- [Usage](#usage)
- [API Documentation](#api-documentation)
- [Contributing](#contributing)
- [License](#license)

## Project Overview

The Hotel Reservation System is designed to manage room reservations in a hotel. Users can register, log in, and reserve available rooms. The system ensures that rooms cannot be double-booked, and it automatically marks rooms as unavailable once they are reserved.

## Features

- User registration and login with JWT authentication.
- CRUD operations for room reservations.
- Ensures rooms are not double-booked by checking availability between check-in and check-out dates.
- Automatically updates room availability after a reservation is made or deleted.
- Comprehensive API documentation with Swagger.

## Technologies Used

- **ASP.NET Core**: Web framework for building APIs.
- **Entity Framework Core**: ORM for database access.
- **JWT**: Authentication using JSON Web Tokens.
- **SQL Server**: Database management system.
- **Swagger**: API documentation and testing.
- **Serilog**: Logging framework.

## Project Structure

The project follows a layered architecture, making it easy to manage and scale. Below is the directory structure:

```plaintext
HotelReservationSystem/
│
├── HotelReservation.Api/             # API project
│   ├── Controllers/                  # API controllers (e.g., AuthController, ReservationsController)
│   ├── Models/                       # Data transfer models and request/response classes
│   ├── Startup.cs                    # Configuration of services, middleware, and routing
│   └── Program.cs                    # Main entry point of the application
│
├── HotelReservation.Application/     # Application layer (services)
│   ├── Services/                     # Business logic services (e.g., ReservationService, UserService)
│   └── Interfaces/                   # Service interfaces
│
├── HotelReservation.Core/            # Core layer (entities, interfaces)
│   ├── Entities/                     # Domain entities (e.g., Reservation, Room, User)
│   └── Interfaces/                   # Repository interfaces
│
├── HotelReservation.Infrastructure/  # Infrastructure layer (data access)
│   ├── Data/                         # Database context (HotelReservationContext)
│   └── Repositories/                 # Repository implementations
│
└── README.md                         # Project documentation
