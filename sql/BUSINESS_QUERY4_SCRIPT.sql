SELECT 
    a.age_group,
    g.gender,
    r.road_user,
    COUNT(DISTINCT f.crash_id) AS crash_count,
    SUM(f.number_fatalities) AS total_fatalities,
    ROUND(SUM(f.number_fatalities) * 100.0 / SUM(SUM(f.number_fatalities)) OVER(), 2) AS pct_of_all_fatalities
FROM 
    fact_fatalities f
JOIN 
    age_dim a ON f.AgeKey = a.AgeKey
JOIN 
    gender_dim g ON f.GenderKey = g.GenderKey
JOIN 
    road_user_dim r ON f.RoadUserKey = r.RoadUserKey
WHERE 
    a.age_group != 'Missing' AND
    g.gender != 'Missing' AND
    r.road_user != 'Missing'
GROUP BY 
    a.age_group, g.gender, r.road_user
ORDER BY 
    total_fatalities DESC,
    a.age_group,
    g.gender,
    r.road_user;