-- Table Definitions
CREATE TABLE
  rockets (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    type TEXT NOT NULL,
    country TEXT NOT NULL,
    manufacturer TEXT NOT NULL,
    launch_date DATETIME,
    landing_date DATETIME,
    status TEXT NOT NULL
  );

CREATE TABLE
  satellites (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    type TEXT NOT NULL,
    country TEXT NOT NULL,
    manufacturer TEXT NOT NULL,
    launch_date DATETIME,
    landing_date DATETIME,
    status TEXT NOT NULL
  );

CREATE TABLE
  launch_sites (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    country TEXT NOT NULL,
    location TEXT NOT NULL
  );

CREATE TABLE
  landing_sites (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    country TEXT,
    location TEXT NOT NULL
  );

CREATE TABLE
  launches (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    rocket_id INTEGER NOT NULL,
    launch_site_id INTEGER NOT NULL,
    launch_date DATETIME NOT NULL,
    launch_status TEXT NOT NULL,
    FOREIGN KEY (rocket_id) REFERENCES rockets (id),
    FOREIGN KEY (launch_site_id) REFERENCES launch_sites (id)
  );

CREATE TABLE
  landings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    rocket_id INTEGER NOT NULL,
    landing_site_id INTEGER NOT NULL,
    landing_date DATETIME NOT NULL,
    landing_status TEXT NOT NULL,
    FOREIGN KEY (rocket_id) REFERENCES rockets (id),
    FOREIGN KEY (landing_site_id) REFERENCES landing_sites (id)
  );

-- Indexes
CREATE INDEX rockets_name_index ON rockets (name);

CREATE INDEX satellites_name_index ON satellites (name);

CREATE INDEX launches_launch_date_index ON launches (launch_date);

CREATE INDEX landings_landing_date_index ON landings (landing_date);

-- Views
CREATE VIEW
  rocket_launch_history AS
SELECT
  rockets.id,
  rockets.name,
  launches.launch_date,
  landings.landing_date
FROM
  rockets
  INNER JOIN launches ON rockets.id = launches.rocket_id
  INNER JOIN landings ON launches.rocket_id = landings.rocket_id;