USE [master]
GO
/****** Object:  Database [HotelReservation]    Script Date: 8/26/2024 3:48:43 PM ******/
CREATE DATABASE [HotelReservation]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HotelReservation', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.ANGEL\MSSQL\DATA\HotelReservation.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'HotelReservation_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.ANGEL\MSSQL\DATA\HotelReservation_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [HotelReservation] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HotelReservation].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HotelReservation] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HotelReservation] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HotelReservation] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HotelReservation] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HotelReservation] SET ARITHABORT OFF 
GO
ALTER DATABASE [HotelReservation] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HotelReservation] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HotelReservation] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HotelReservation] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HotelReservation] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HotelReservation] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HotelReservation] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HotelReservation] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HotelReservation] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HotelReservation] SET  DISABLE_BROKER 
GO
ALTER DATABASE [HotelReservation] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HotelReservation] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HotelReservation] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HotelReservation] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HotelReservation] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HotelReservation] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HotelReservation] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HotelReservation] SET RECOVERY FULL 
GO
ALTER DATABASE [HotelReservation] SET  MULTI_USER 
GO
ALTER DATABASE [HotelReservation] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HotelReservation] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HotelReservation] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HotelReservation] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HotelReservation] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [HotelReservation] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'HotelReservation', N'ON'
GO
ALTER DATABASE [HotelReservation] SET QUERY_STORE = OFF
GO
USE [HotelReservation]
GO
/****** Object:  User [jo]    Script Date: 8/26/2024 3:48:43 PM ******/
CREATE USER [jo] FOR LOGIN [jo] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Reservations]    Script Date: 8/26/2024 3:48:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservations](
	[ReservationId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[RoomId] [int] NOT NULL,
	[ReservationDate] [datetime] NOT NULL,
	[CheckInDate] [datetime] NOT NULL,
	[CheckOutDate] [datetime] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ReservationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rooms]    Script Date: 8/26/2024 3:48:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rooms](
	[RoomId] [int] IDENTITY(1,1) NOT NULL,
	[RoomNumber] [nvarchar](50) NOT NULL,
	[RoomType] [nvarchar](100) NOT NULL,
	[IsAvailable] [bit] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoleMappings]    Script Date: 8/26/2024 3:48:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoleMappings](
	[UserRoleMappingId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserRoleMappingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 8/26/2024 3:48:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](100) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 8/26/2024 3:48:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](200) NOT NULL,
	[PasswordHash] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Reservations] ON 
GO
INSERT [dbo].[Reservations] ([ReservationId], [UserId], [RoomId], [ReservationDate], [CheckInDate], [CheckOutDate], [CreatedAt]) VALUES (2, 1, 2, CAST(N'2024-08-26T15:44:28.613' AS DateTime), CAST(N'2024-08-26T12:39:02.757' AS DateTime), CAST(N'2024-08-26T12:39:02.757' AS DateTime), CAST(N'2024-08-26T15:44:28.613' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Reservations] OFF
GO
SET IDENTITY_INSERT [dbo].[Rooms] ON 
GO
INSERT [dbo].[Rooms] ([RoomId], [RoomNumber], [RoomType], [IsAvailable], [CreatedAt]) VALUES (1, N'Room-101', N'Double', 0, CAST(N'2024-08-26T15:42:26.450' AS DateTime))
GO
INSERT [dbo].[Rooms] ([RoomId], [RoomNumber], [RoomType], [IsAvailable], [CreatedAt]) VALUES (2, N'Room-102', N'Suite', 1, CAST(N'2024-08-26T15:42:26.450' AS DateTime))
GO
INSERT [dbo].[Rooms] ([RoomId], [RoomNumber], [RoomType], [IsAvailable], [CreatedAt]) VALUES (3, N'Room-103', N'Single', 0, CAST(N'2024-08-26T15:42:26.450' AS DateTime))
GO
INSERT [dbo].[Rooms] ([RoomId], [RoomNumber], [RoomType], [IsAvailable], [CreatedAt]) VALUES (4, N'Room-104', N'Double', 1, CAST(N'2024-08-26T15:42:26.450' AS DateTime))
GO
INSERT [dbo].[Rooms] ([RoomId], [RoomNumber], [RoomType], [IsAvailable], [CreatedAt]) VALUES (5, N'Room-105', N'Suite', 0, CAST(N'2024-08-26T15:42:26.450' AS DateTime))
GO
INSERT [dbo].[Rooms] ([RoomId], [RoomNumber], [RoomType], [IsAvailable], [CreatedAt]) VALUES (6, N'Room-106', N'Single', 1, CAST(N'2024-08-26T15:42:26.450' AS DateTime))
GO
INSERT [dbo].[Rooms] ([RoomId], [RoomNumber], [RoomType], [IsAvailable], [CreatedAt]) VALUES (7, N'Room-107', N'Double', 0, CAST(N'2024-08-26T15:42:26.450' AS DateTime))
GO
INSERT [dbo].[Rooms] ([RoomId], [RoomNumber], [RoomType], [IsAvailable], [CreatedAt]) VALUES (8, N'Room-108', N'Suite', 1, CAST(N'2024-08-26T15:42:26.450' AS DateTime))
GO
INSERT [dbo].[Rooms] ([RoomId], [RoomNumber], [RoomType], [IsAvailable], [CreatedAt]) VALUES (9, N'Room-109', N'Single', 0, CAST(N'2024-08-26T15:42:26.450' AS DateTime))
GO
INSERT [dbo].[Rooms] ([RoomId], [RoomNumber], [RoomType], [IsAvailable], [CreatedAt]) VALUES (10, N'Room-110', N'Double', 1, CAST(N'2024-08-26T15:42:26.450' AS DateTime))
GO
INSERT [dbo].[Rooms] ([RoomId], [RoomNumber], [RoomType], [IsAvailable], [CreatedAt]) VALUES (11, N'Room-111', N'Suite', 0, CAST(N'2024-08-26T15:42:26.453' AS DateTime))
GO
INSERT [dbo].[Rooms] ([RoomId], [RoomNumber], [RoomType], [IsAvailable], [CreatedAt]) VALUES (12, N'Room-112', N'Single', 1, CAST(N'2024-08-26T15:42:26.453' AS DateTime))
GO
INSERT [dbo].[Rooms] ([RoomId], [RoomNumber], [RoomType], [IsAvailable], [CreatedAt]) VALUES (13, N'Room-113', N'Double', 0, CAST(N'2024-08-26T15:42:26.453' AS DateTime))
GO
INSERT [dbo].[Rooms] ([RoomId], [RoomNumber], [RoomType], [IsAvailable], [CreatedAt]) VALUES (14, N'Room-114', N'Suite', 1, CAST(N'2024-08-26T15:42:26.453' AS DateTime))
GO
INSERT [dbo].[Rooms] ([RoomId], [RoomNumber], [RoomType], [IsAvailable], [CreatedAt]) VALUES (15, N'Room-115', N'Single', 0, CAST(N'2024-08-26T15:42:26.453' AS DateTime))
GO
INSERT [dbo].[Rooms] ([RoomId], [RoomNumber], [RoomType], [IsAvailable], [CreatedAt]) VALUES (16, N'Room-116', N'Double', 1, CAST(N'2024-08-26T15:42:26.453' AS DateTime))
GO
INSERT [dbo].[Rooms] ([RoomId], [RoomNumber], [RoomType], [IsAvailable], [CreatedAt]) VALUES (17, N'Room-117', N'Suite', 0, CAST(N'2024-08-26T15:42:26.453' AS DateTime))
GO
INSERT [dbo].[Rooms] ([RoomId], [RoomNumber], [RoomType], [IsAvailable], [CreatedAt]) VALUES (18, N'Room-118', N'Single', 1, CAST(N'2024-08-26T15:42:26.453' AS DateTime))
GO
INSERT [dbo].[Rooms] ([RoomId], [RoomNumber], [RoomType], [IsAvailable], [CreatedAt]) VALUES (19, N'Room-119', N'Double', 0, CAST(N'2024-08-26T15:42:26.453' AS DateTime))
GO
INSERT [dbo].[Rooms] ([RoomId], [RoomNumber], [RoomType], [IsAvailable], [CreatedAt]) VALUES (20, N'Room-120', N'Suite', 1, CAST(N'2024-08-26T15:42:26.453' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Rooms] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([UserId], [Username], [Email], [PasswordHash], [CreatedAt]) VALUES (1, N'angel', N'angelsafwat3@gmail.com', N'$2a$11$HDw5uHWi45WllOZ1IUy4z.HpV6wFpjB81jJV3easuWkpLE6ABH.Vq', CAST(N'2024-08-26T12:55:11.690' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Reservations] ADD  DEFAULT (getdate()) FOR [ReservationDate]
GO
ALTER TABLE [dbo].[Reservations] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Rooms] ADD  DEFAULT ((1)) FOR [IsAvailable]
GO
ALTER TABLE [dbo].[Rooms] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[UserRoleMappings] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[UserRoles] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD FOREIGN KEY([RoomId])
REFERENCES [dbo].[Rooms] ([RoomId])
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[UserRoleMappings]  WITH CHECK ADD FOREIGN KEY([RoleId])
REFERENCES [dbo].[UserRoles] ([RoleId])
GO
ALTER TABLE [dbo].[UserRoleMappings]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
USE [master]
GO
ALTER DATABASE [HotelReservation] SET  READ_WRITE 
GO
