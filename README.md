# SkyTrack Airline System — Database Project

## System Description

SkyTrack is a relational database system designed to manage the core operations of a regional airline. It tracks airports, aircraft, flights, passengers, bookings, and crew assignments. The system enforces data integrity through primary keys, foreign keys, unique constraints, check constraints, and default values — ensuring that only valid, consistent data enters the database at all times.

---

## ERD Summary

### Entities and Key Attributes

| Entity | Primary Key | Notable Attributes |
|---|---|---|
| Airport | IATA | name, city, country |
| Aircraft | reg_num | model, manufacturer, seat_capacity, manufacture_year |
| Flight | flight_num | departure_datetime, arrival_datetime, status |
| Passenger | national_id | f_name, l_name, email, phone, nationality, DOB |
| Booking | booking_id | seat_number, class, price_paid, booking_date |
| Crew_member | license_number | f_name, l_name, role |

### Relationships

- **Airport → Flight (Departs):** One airport can be the origin of many flights. Each flight departs from exactly one airport. This is a 1:M relationship with total participation on the Flight side.
- **Airport → Flight (Arrives):** One airport can be the destination of many flights. Each flight arrives at exactly one airport. Same cardinality as above — modelled as a second, separate relationship between Airport and Flight.
- **Aircraft → Flight (Assigned):** One aircraft can be assigned to many flights over time. Each flight must be assigned exactly one aircraft. This is a 1:M relationship with total participation on the Flight side.
- **Passenger → Booking (Books):** One passenger can make many bookings, but each booking belongs to exactly one passenger. 1:M relationship.
- **Booking → Flight (Associated):** Each booking is linked to exactly one flight, and one flight can have many bookings. 1:M relationship.
- **Flight ↔ Crew_member (Serves):** A flight can have many crew members, and a crew member can serve on many flights. This M:N relationship is resolved through the **Flight_crew** junction table, which holds `flight_num` and `license_number` as a composite primary key.

### Design Decisions

- The two relationships between Airport and Flight (Departs and Arrives) were kept as distinct named relationships rather than merged. This is intentional — they represent different business facts (origin vs. destination) and map to two separate foreign keys (`origin_airport` and `destination_airport`) on the Flight table.
- The M:N relationship between Flight and Crew_member was resolved into a separate `Flight_crew` association table rather than embedding crew data in Flight. This avoids data redundancy and correctly handles the many-to-many nature of crew scheduling.
- `full_name` in both Passenger and Crew_member is a composite attribute (f_name, l_name) shown in the ERD and stored as two separate columns in the physical schema.

---

## Mapping Decisions

### Foreign Key Placement

The logical schema was derived from the ERD by applying standard conversion rules:

- **1:M relationships** — the foreign key is always placed on the "many" side:
  - `Flight` holds `origin_airport` and `destination_airport` (both referencing `Airport.IATA`)
  - `Flight` holds `reg_num` (referencing `Aircraft.reg_num`)
  - `Booking` holds `national_id` (referencing `Passenger.national_id`) and `flight_num` (referencing `Flight.flight_num`)

- **M:N relationship** — resolved into a new junction table:
  - `Flight_crew(flight_num, license_number)` — both columns are foreign keys and together form the composite primary key. This table has no standalone surrogate key because the combination of flight and crew member is itself uniquely identifying.

### Normalization

The schema satisfies 1NF, 2NF, and 3NF:

- **1NF:** All attributes are atomic. Multi-valued attributes like full_name are split into f_name and l_name. No repeating groups exist.
- **2NF:** All non-key attributes are fully dependent on the whole primary key. The junction table `Flight_crew` contains only the two key columns — no partial dependencies exist anywhere.
- **3NF:** No transitive dependencies exist. Every non-key attribute depends directly on the primary key of its table, not on another non-key attribute.

---

## WHERE vs. HAVING

**WHERE** filters rows before any grouping or aggregation happens. It operates on individual rows and cannot reference aggregate functions like `COUNT()` or `SUM()`.

**HAVING** filters groups after a `GROUP BY` has been applied. It is used specifically to place conditions on aggregated results.

A practical way to remember the distinction: WHERE asks "which rows do I want to keep before I group?", while HAVING asks "which groups do I want to keep after I aggregate?"

**Example:**

```sql
-- WHERE: filter individual bookings before grouping
SELECT flight_num, COUNT(*) AS total_bookings
FROM Booking
WHERE class = 'Economy'
GROUP BY flight_num
HAVING COUNT(*) > 2;
-- HAVING: keep only groups where the count exceeds 2
```

In the query above, WHERE first reduces the rows to Economy bookings only, then GROUP BY aggregates them by flight, and finally HAVING discards any flight with two or fewer Economy bookings.
