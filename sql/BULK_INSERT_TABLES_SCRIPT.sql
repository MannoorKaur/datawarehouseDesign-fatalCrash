--1) Loading in Road User Dim
COPY road_user_dim(roaduserkey,road_user,user_type)
FROM '/tmp/road_user_dim.csv'
WITH (FORMAT csv, DELIMITER ',', HEADER false);

--2)Loading in Crash Type Dim
COPY crash_type_dim("crashtypekey","crash_type")
FROM '/tmp/crash_type_dim.csv'
WITH (FORMAT csv, DELIMITER ',', HEADER false);

--3) Loading in Location Dim
COPY location_dim("locationkey","state","remoteness","road_type","sa4_name","lga_name")
FROM '/tmp/location_dim.csv'
WITH (FORMAT csv, DELIMITER ',', HEADER false);

--4)Loading in Age Dim
COPY age_dim("agekey","age_group")
FROM '/tmp/age_dim.csv'
WITH (FORMAT csv, DELIMITER ',', HEADER false);

--5)Loading in Gender Dim
COPY gender_dim("genderkey","gender","gender_known")
FROM '/tmp/gender_dim.csv'
WITH (FORMAT csv, DELIMITER ',', HEADER false);

--6)Loading in Date Dim
COPY date_dim("datekey","year","quarter","month","day_name","day_type","time_of_day",
              "christmas_period","easter_period","is_holiday")
FROM '/tmp/date_dim.csv'
WITH (FORMAT csv, DELIMITER ',', HEADER false);

--7)Loading in Speed Dim
COPY speed_dim("speedkey","speed_limit_crash","speed_category")
FROM '/tmp/speed_dim.csv'
WITH (FORMAT csv, DELIMITER ',', HEADER false);

--8)Loading in Vehicle Dim
COPY vehicle_dim("vehiclekey","bus_involvement_crash","heavy_rigid_truck_involvement_crash"
                 ,"articulated_truck_involvement_crash")
FROM '/tmp/vehicle_dim.csv'
WITH (FORMAT csv, DELIMITER ',', HEADER false);

--9)Loading in the Fact Fatalities Data
COPY fact_fatalities(FactFatalityID,crash_id, SpeedKey, AgeKey, RoadUserKey, CrashTypeKey,LocationKey, DateKey, GenderKey, VehicleKey, crash_count, number_fatalities
)
FROM '/tmp/fact_fatalities.csv'
WITH (FORMAT csv, DELIMITER ',', HEADER false);

