SELECT 
    CASE 
        WHEN v.bus_involvement_crash = 1 THEN 'Yes'
        WHEN v.bus_involvement_crash = 0 THEN 'No'
        ELSE 'Unknown'
    END AS bus_involved,
    
    CASE 
        WHEN v.heavy_rigid_truck_involvement_crash = 1 THEN 'Yes'
        WHEN v.heavy_rigid_truck_involvement_crash = 0 THEN 'No'
        ELSE 'Unknown'
    END AS heavy_rigid_involved,
    
    CASE 
        WHEN v.articulated_truck_involvement_crash = 1 THEN 'Yes'
        WHEN v.articulated_truck_involvement_crash = 0 THEN 'No'
        ELSE 'Unknown'
    END AS articulated_truck_involved,
    
    COUNT(DISTINCT f.crash_id) AS crash_count,
    SUM(f.number_fatalities) AS total_fatalities,
    ROUND(SUM(f.number_fatalities) * 1.0 / COUNT(DISTINCT f.crash_id), 2) AS fatalities_per_crash
FROM 
    fact_fatalities f
JOIN 
    vehicle_dim v ON f.VehicleKey = v.VehicleKey
GROUP BY 
    CASE 
        WHEN v.bus_involvement_crash = 1 THEN 'Yes'
        WHEN v.bus_involvement_crash = 0 THEN 'No'
        ELSE 'Unknown'
    END,
    CASE 
        WHEN v.heavy_rigid_truck_involvement_crash = 1 THEN 'Yes'
        WHEN v.heavy_rigid_truck_involvement_crash = 0 THEN 'No'
        ELSE 'Unknown'
    END,
    CASE 
        WHEN v.articulated_truck_involvement_crash = 1 THEN 'Yes'
        WHEN v.articulated_truck_involvement_crash = 0 THEN 'No'
        ELSE 'Unknown'
    END
ORDER BY 
    total_fatalities DESC;