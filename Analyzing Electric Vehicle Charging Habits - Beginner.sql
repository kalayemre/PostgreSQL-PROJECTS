/*
As electronic vehicles (EVs) become more popular, there is an increasing need for access to charging stations, also known as ports.
To that end, many modern apartment buildings have begun retrofitting their parking garages to include shared charging stations.
A charging station is shared if it is accessible by anyone in the building.

EV Charging
But with increasing demand comes competition for these ports — nothing is more frustrating than coming home to find no charging stations available!
In this project, you will use a dataset to help apartment building managers better understand their tenants’ EV charging habits.

The data has been loaded into a PostgreSQL database with a table named charging_sessions with the following columns:

charging_sessions table:

Column	Definition	Data type
garage_id	Identifier for the garage/building	VARCHAR
user_id	Identifier for the individual user	VARCHAR
user_type	Indicating whether the station is Shared or Private	VARCHAR
start_plugin	The date and time the session started	DATETIME
start_plugin_hour	The hour (in military time) that the session started	NUMERIC
end_plugout	The date and time the session ended	DATETIME
end_plugout_hour	The hour (in military time) that the session ended	NUMERIC
duration_hours	The length of the session, in hours	NUMERIC
el_kwh	Amount of electricity used (in Kilowatt hours)	NUMERIC
month_plugin	The month that the session started	VARCHAR
weekdays_plugin	The day of the week that the session started	VARCHAR
Let’s get started!
*/

/*
PART ONE:

Find the number of unique individuals that use each garage’s shared charging stations.
The output should contain two columns: garage_id and num_unique_users. Sort your results by the number of unique users from highest to lowest.
Save the result as unique_users_per_garage.
*/

SELECT garage_id, COUNT(DISTINCT user_id) AS num_unique_users
FROM charging_sessions
WHERE user_type = 'Shared'
GROUP BY garage_id
ORDER BY num_unique_users DESC;


/*
PART TWO:

Find the top 10 most popular charging start times (by weekday and start hour) for sessions that use shared charging stations.
Your result should contain three columns: weekdays_plugin, start_plugin_hour, and a column named num_charging_sessions containing
the number of plugins on that weekday at that hour. Sort your results from the most to the least number of sessions. Save the result
as most_popular_shared_start_times.
*/

SELECT weekdays_plugin, start_plugin_hour, COUNT(*) AS num_charging_sessions
FROM charging_sessions
WHERE user_type = 'Shared'
GROUP BY weekdays_plugin, start_plugin_hour
ORDER BY num_charging_sessions DESC
LIMIT 10

/*
PART THREE:

Find the users whose average charging duration last longer than 10 hours when using shared charging stations.
Your result should contain two columns: user_id and avg_charging_duration. Sort your result from highest to lowest average charging duration.
Save the result as long_duration_shared_users.
*/

SELECT user_id, AVG(duration_hours) AS avg_charging_duration
FROM charging_sessions 
WHERE user_type = 'Shared'
GROUP BY user_id
HAVING AVG(duration_hours) > 10
ORDER BY AVG(duration_hours) DESC
