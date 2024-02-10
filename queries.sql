-- Rockets

INSERT INTO rockets (name, type, country, manufacturer, launch_date, landing_date, status)
VALUES ('Falcon 9', 'Heavy', 'United States', 'SpaceX', '2023-10-20', '2023-10-20', 'Active'),
('Falcon Heavy', 'Super Heavy', 'United States', 'SpaceX', '2023-11-01', '2023-11-01', 'Active'),
('Starship', 'Super Heavy', 'United States', 'SpaceX', '2023-12-01', '2023-12-01', 'Active'),
('New Glenn', 'New Shepard', 'United States', 'Blue Origin', '2023-12-31', '2024-01-01', 'Active'),
('Ariane 6', 'Ariane 5', 'France', 'ArianeGroup', '2024-03-01', '2024-03-01', 'Active');

-- Satellites

INSERT INTO satellites (name, type, country, manufacturer, launch_date, landing_date, status)
VALUES ('Starlink-12345', 'Communication', 'United States', 'SpaceX', '2023-10-20', '2023-10-20', 'Active'),
('James Webb Space Telescope', 'Observatory', 'United States', 'NASA', '2021-12-25', '2021-12-25', 'Active'),
('Hubble Space Telescope', 'Observatory', 'United States', 'NASA', '1990-04-24', '2019-10-31', 'Retired'),
('Voyager 1', 'Probe', 'United States', 'NASA', '1977-09-05', '', 'Active'),
('Voyager 2', 'Probe', 'United States', 'NASA', '1977-08-20', '', 'Active');

-- Launch sites

INSERT INTO launch_sites (name, country, location)
VALUES ('Kennedy Space Center', 'United States', 'Cape Canaveral, Florida'),
('Cape Canaveral Air Force Station', 'United States', 'Cape Canaveral, Florida'),
('Vandenberg Space Force Base', 'United States', 'Santa Barbara County, California'),
('Baikonur Cosmodrome', 'Russia', 'Kyzylorda Region, Kazakhstan'),
('Jiuquan Satellite Launch Center', 'China', 'Aksu Prefecture, Xinjiang');

-- Landing sites

INSERT INTO landing_sites (name, country, location)
VALUES ('Cape Canaveral Landing Complex 1', 'United States', 'Cape Canaveral, Florida'),
('Cape Canaveral Landing Complex 2', 'United States', 'Cape Canaveral, Florida'),
('Landing Zone 1', 'United States', 'McGregor, Texas'),
('Landing Zone 2', '', 'Mars'),
('Xichang Satellite Launch Center', 'China', 'Xichang, Sichuan');

-- Launches

INSERT INTO launches (rocket_id, launch_site_id, launch_date, launch_status)
VALUES (1, 1, '2023-10-20', 'success'),
(2, 1, '2023-11-01', 'success'),
(3, 1, '2023-12-01', 'success'),
(4, 1, '2023-12-31', 'success'),
(5, 1, '2024-03-01', 'success');

-- Landings

INSERT INTO landings (rocket_id, landing_site_id, landing_date, landing_status)
VALUES (1, 1, '2023-10-20', 'success'),
(2, 1, '2023-11-01', 'success'),
(3, 1, '2023-12-01', 'success'),
(4, 1, '2023-12-31', 'failed'),
(5, 1, '2024-03-01', 'success');


-- Get a list of all rockets
SELECT
  *
FROM
  rockets;

-- Get a list of all satellites
SELECT
  *
FROM
  satellites;

-- Get a list of all launch sites
SELECT
  *
FROM
  launch_sites;

-- Get a list of all landing sites
SELECT
  *
FROM
  landing_sites;

-- Get a list of all launches
SELECT
  *
FROM
  launches;

-- Get a list of all landings
SELECT
  *
FROM
  landings;

-- Get a list of all rockets that have launched from a specific launch site
SELECT
  *
FROM
  rockets
  JOIN launches ON rockets.id = launches.rocket_id
WHERE
  launches.launch_site_id = 1;

-- Get a list of all satellites that have landed on a specific landing site
SELECT
  *
FROM
  satellites
  JOIN landings ON satellites.id = landings.rocket_id
WHERE
  landings.landing_site_id = 1;

-- Get a list of all launches that have been success
SELECT
  *
FROM
  launches
WHERE
  launch_status = 'success';

-- Get a list of all landings that have been success
SELECT
  *
FROM
  landings
WHERE
  landing_status = 'success';

-- Get a list of all rockets that have launched and landed successly
SELECT
  *
FROM
  rockets
WHERE
  rockets.id IN (
    SELECT
      rocket_id
    FROM
      launches
    WHERE
      launch_status = 'success'
      AND rocket_id IN (
        SELECT
          rocket_id
        FROM
          landings
        WHERE
          landing_status = 'success'
      )
  );

-- Get list of the top 5 countries by number of launches
SELECT
  launch_site_id,
  COUNT(*) AS num_launches
FROM
  launches
GROUP BY
  launch_site_id
ORDER BY
  num_launches DESC
LIMIT
  5;

-- Get list of all launches and landings for a specific rocket
SELECT
  *
FROM
  launches
  JOIN landings ON launches.rocket_id = landings.rocket_id
WHERE
  launches.rocket_id = 1;