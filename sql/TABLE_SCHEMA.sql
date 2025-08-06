-- Dimension Tables
 
CREATE TABLE speed_dim (
    SpeedKey SERIAL PRIMARY KEY NOT NULL,
    speed_limit_crash INTEGER,
    speed_category VARCHAR(20)
);
 
CREATE TABLE age_dim (
    AgeKey SERIAL PRIMARY KEY NOT NULL,
    age_group VARCHAR(20)
);
 
CREATE TABLE road_user_dim (
    RoadUserKey SERIAL PRIMARY KEY NOT NULL,
    road_user VARCHAR(50),
    user_type VARCHAR(30)
);
 
CREATE TABLE crash_type_dim (
    CrashTypeKey SERIAL PRIMARY KEY NOT NULL,
    crash_type VARCHAR(30)
);
 
CREATE TABLE location_dim (
    LocationKey SERIAL PRIMARY KEY NOT NULL,
    state VARCHAR(10),
    remoteness VARCHAR(50),
    road_type VARCHAR(50),
    sa4_name VARCHAR(100),
    lga_name VARCHAR(100)
);
 
CREATE TABLE date_dim (
    DateKey SERIAL PRIMARY KEY NOT NULL,
    year INTEGER,
    quarter INTEGER,
    month INTEGER,
    day_name VARCHAR(15),
    day_type VARCHAR(15),
    time_of_day VARCHAR(15),
    christmas_period INTEGER,
    easter_period INTEGER,
    is_holiday INTEGER
);
 
CREATE TABLE gender_dim (
    GenderKey SERIAL PRIMARY KEY NOT NULL,
    gender VARCHAR(10),
    gender_known INTEGER
);
 
CREATE TABLE vehicle_dim (
    VehicleKey SERIAL PRIMARY KEY NOT NULL,
    bus_involvement_crash INTEGER,
    heavy_rigid_truck_involvement_crash INTEGER,
    articulated_truck_involvement_crash INTEGER
);
 
-- Fact Table
 
CREATE TABLE fact_fatalities (
    FactFatalityID INTEGER PRIMARY KEY NOT NULL,
    crash_id BIGINT,
    SpeedKey INTEGER NOT NULL REFERENCES speed_dim(SpeedKey),
    AgeKey INTEGER NOT NULL REFERENCES age_dim(AgeKey),
    RoadUserKey INTEGER NOT NULL REFERENCES road_user_dim(RoadUserKey),
    CrashTypeKey INTEGER NOT NULL REFERENCES crash_type_dim(CrashTypeKey),
    LocationKey INTEGER NOT NULL REFERENCES location_dim(LocationKey),
    DateKey INTEGER NOT NULL REFERENCES date_dim(DateKey),
    GenderKey INTEGER NOT NULL REFERENCES gender_dim(GenderKey),
    VehicleKey INTEGER NOT NULL REFERENCES vehicle_dim(VehicleKey),
    crash_count INTEGER,
    number_fatalities INTEGER
);