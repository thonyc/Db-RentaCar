CREATE TABLE [alquiler] (
  [idalquiler] int NOT NULL,
  [fechaInicio] datetime NOT NULL,
  [fechaFin] datetime NOT NULL,
  [reservacionId] int NOT NULL,
  [estado] varchar(10) NOT NULL,
  [comentario] varchar(100) NULL,
  PRIMARY KEY CLUSTERED ([idalquiler])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO

CREATE TABLE [clientes] (
  [idcliente] int IDENTITY NOT NULL,
  [nit] varchar(10) NOT NULL,
  [nombre] varchar(60) NOT NULL,
  [telefono] varchar(10) NOT NULL,
  [direccion] varchar(60) NULL,
  PRIMARY KEY CLUSTERED ([idcliente])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO

CREATE TABLE [garajes] (
  [idgaraje] int NOT NULL,
  [descripcion] varchar(255) NOT NULL,
  [estado ] varchar(10) NOT NULL,
  PRIMARY KEY CLUSTERED ([idgaraje])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO

CREATE TABLE [reservaciones] (
  [idreservacion] int IDENTITY(1,1) NOT NULL,
  [fechaReservacion] datetime NOT NULL,
  [clienteId] int NOT NULL,
  [estado] varchar(10) DEFAULT NULL NOT NULL,
  [vehiculoId] int NOT NULL,
  PRIMARY KEY CLUSTERED ([idreservacion])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
ALTER TABLE [reservaciones] SET (LOCK_ESCALATION = AUTO)
GO

CREATE TABLE [vehiculos] (
  [idvehiculo] int IDENTITY(1,1) NOT NULL,
  [matricula] varchar(255) NOT NULL,
  [marca] varchar(255) NOT NULL,
  [color] varchar(255) NOT NULL,
  [precio_alquiler] decimal(10,5) NOT NULL,
  [garajeId] int NOT NULL,
  [estado] varchar(10) NOT NULL,
  PRIMARY KEY CLUSTERED ([idvehiculo])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON),
  CONSTRAINT [garajeId] UNIQUE CLUSTERED ([garajeId])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
ALTER TABLE [vehiculos] SET (LOCK_ESCALATION = AUTO)
GO

ALTER TABLE [alquiler] ADD CONSTRAINT [fk_alquiler_reservaciones_1] FOREIGN KEY ([reservacionId]) REFERENCES [reservaciones] ([idreservacion])
GO
ALTER TABLE [reservaciones] ADD CONSTRAINT [fk_reservaciones_vehiculos_1] FOREIGN KEY ([vehiculoId]) REFERENCES [vehiculos] ([idvehiculo])
GO
ALTER TABLE [reservaciones] ADD CONSTRAINT [fk_reservaciones_clientes_1] FOREIGN KEY ([clienteId]) REFERENCES [clientes] ([idcliente])
GO
ALTER TABLE [vehiculos] ADD CONSTRAINT [fk_vehiculos_garajes_1] FOREIGN KEY ([garajeId]) REFERENCES [garajes] ([idgaraje])
GO

