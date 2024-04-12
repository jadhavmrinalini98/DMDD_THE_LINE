CREATE OR REPLACE VIEW running_trains AS
SELECT t.train_id, t.source_station_id, t.target_station_id, t.train_capacity,
       (SELECT COUNT(passenger_count)
        FROM transaction tr
        WHERE tr.train_train_id = t.train_id) AS total_passengers
FROM train t
JOIN schedule s ON t.train_id = s.train_train_id
WHERE s.departure_time < to_timestamp(SYSDATE);

SELECT * FROM running_trains;


CREATE OR REPLACE VIEW onboarded_passengers AS
SELECT p.passenger_name, p.residual_city, p.passenger_type, tr.onboard_station_id, tr.train_train_id
FROM passenger p
JOIN transaction tr ON p.passenger_id = tr.passenger_passenger_id
WHERE tr.ONBOARD_STATION_ID IS NOT NULL;

select * from onboarded_passengers;

