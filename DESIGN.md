# Design Document

By Giridhar Talla (New Delhi, India)

Video overview: https://youtu.be/bsvs8VUH338

## Scope

This database tracks the launches and landings of rockets and satellites from around the world. It includes information on the rockets, satellites, launches, and landings. This data can be used for a variety of purposes, such as:

* Tracking the progress of the space industry
* Analyzing launch and landing trends
* Identifying potential problems and areas for improvement
* Supporting research and development efforts

The main tables in the database's scope include:

* Rockets, including the details about the rocket
* Satellites, including the basic information about the satellite
* Launch site, including the location from which the rocket is launched
* Landing site, including the landing location of the space craft (mars, moon or return to earth)
* Launch, including the status and date of launch
* Landing, including the status and date of landing

## Functional Requirements

Users should be able to:

* View a list of all rockets, satellites, launch sites, landing sites, launches, and landings
* Search for rockets, satellites, launch sites, landing sites, launches, and landings by name
* View detailed information about a rocket launches
* Add, edit rockets, satellites, and related information

Users should not be able to:

* Control the rockets 🤣
* Delete rocket information

## Representation

![er diagram of space database](image.png)

### Entities

The database includes the following entities:

#### Rockets

The `rockets` table includes:

* `id`, which specifies the unique ID for the rocket as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `name`, which specifies the rocket's name as `TEXT`.
* `type`, which specifies the rocket's type as `TEXT`.
* `country`, which specifies the rocket's country of origin as `TEXT`.
* `manufacturer`, which specifies the rocket's manufacturer as `TEXT`.
* `launch_date`, which specifies the rocket's launch date as a `DATETIME` timestamp.
* `landing_date`, which specifies the rocket's landing date as a `DATETIME` timestamp.
* `status`, which specifies the rocket's current status as `TEXT`.

All columns except the dates are required and hence have the `NOT NULL` constraint applied.

#### Satellites

The `satellites` table includes:

* `id`, which specifies the unique ID for the satellite as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `name`, which specifies the satellite's name as `TEXT`.
* `type`, which specifies the satellite's type as `TEXT`.
* `country`, which specifies the satellite's country of origin as `TEXT`.
* `manufacturer`, which specifies the satellite's manufacturer as `TEXT`.
* `launch_date`, which specifies the satellite's launch date as a `DATETIME` timestamp.
* `landing_date`, which specifies the satellite's landing date as a `DATETIME` timestamp.
* `status`, which specifies the satellite's current status as `TEXT`.

All columns except the dates are required and hence have the `NOT NULL` constraint applied.

#### Launch sites

The `launch_sites` table includes:

* `id`, which specifies the unique ID for the launch site as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `name`, which specifies the launch site's name as `TEXT`.
* `country`, which specifies the launch site's country as `TEXT`.
* `location`, which specifies the launch site's location as `TEXT`.

All columns are required and hence have the `NOT NULL` constraint applied.

#### Landing sites

The `landing_sites` table includes:

* `id`, which specifies the unique ID for the landing site as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `name`, which specifies the landing site's name as `TEXT`.
* `country`, which specifies the landing site's country as `TEXT`.
* `location`, which specifies the landing site's location as `TEXT`.

The `location` is required and hence have the `NOT NULL` constraint applied, but the `name` and `country` depends on location (if it lands on mars, it will not have country) hence can be `NULL`.

#### Launches

The `launches` table includes:

* `id`, which specifies the unique ID for the launch as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `rocket_id`, which is the ID of the rocket that was launched as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `rockets` table.
* `launch_site_id`, which is the ID of the launch site from which the rocket was launched as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `launch_sites` table.
* `launch_date`, which specifies the launch date as a `DATETIME` timestamp.
* `launch_status`, which specifies the launch status as `TEXT`.

All columns are required and hence have the `NOT NULL` constraint applied.

#### Landings

The `landings` table includes:

* `id`, which specifies the unique ID for the landing as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `rocket_id`, which is the ID of the rocket that landed as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `rockets` table.
* `landing_site_id`, which is the ID of the landing site where the rocket landed as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `landing_sites` table.
* `landing_date`, which specifies the landing date as a `DATETIME` timestamp.
* `landing_status`, which specifies the landing status as `TEXT`.

All columns are required and hence have the `NOT NULL` constraint applied.

### Relationships

The relationships between the entities can be described as below:

* A rocket can have many launches
* A launch can have only one rocket
* A satellite can have many launches
* A launch can have only one satellite (for simplicity)
* A launch site can have many launches
* A launch can have only one launch site
* A landing site can have many landings
* A landing can have only one landing site

## Optimizations

**Indexes:**

- An index on the `name` column of "Rocket" and "Satellite" would improve the performance of search queries.
- An index on the `launch_date` and `landing_date` columns of the "Launch" and "Landing" entities would improve the performance of queries that filter by launch or landing date.

**Views:**

- A view that combines the "Rocket", "Launch", and "Landing" entities into a single table would make it easier for users to view a complete history of a rocket's launches and landings.

## Limitations

- For the sake simplicity, the scenario of a rocket carrying multiple satellites is ignored.
- The database does not represent the orbits of satellites.
- The database does not represent the payloads of rockets and satellites.
