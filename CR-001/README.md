# SkyTrack Airline System — CR-001: Extended System Information

## Summary of Changes

CR-001 extends the original SkyTrack database to capture four areas of operational information that were not part of the initial design. The business need behind each addition is described below:

1. **Airline Operator** — The original system tracked flights but had no record of which airline operated them. Multiple airlines may share the same infrastructure, so each flight now links to a specific airline entity.
2. **Departure Gate** — Gate assignment is a standard part of flight scheduling. The system must now store gate information per airport and associate each flight with the gate it departs from.
3. **Baggage** — Baggage tracking per booking was entirely absent. The business needs to record each baggage item individually, including weight and type (Cabin or Checked).
4. **Flight Delay Log** — When a flight is delayed, operations staff need to log the reason, duration, and timestamp. A single flight may be delayed more than once, so this requires a separate log table rather than a single column on the Flight table.

---

## New Tables Added

### Airline
Stores information about airline operators. Each airline has a surrogate primary key (`airline_id`), a unique IATA code, a full name, a country of registration, and a contact email. All fields are NOT NULL and the IATA code, name, and email carry UNIQUE constraints.

### Gate
Stores departure gates belonging to airports. Each gate has a surrogate primary key (`gate_id`), a gate code, a terminal name, and a foreign key to `Airport`. The combination of `(gate_code, airport_id)` is UNIQUE, meaning the same gate code can exist at different airports but not twice within the same one.

### Baggage
Stores individual baggage items linked to bookings. Each record has a surrogate primary key (`baggage_id`), a unique tag number, a weight in kilograms, a type restricted to `'Cabin'` or `'Checked'`, and a foreign key to `Booking`. Cascades on delete and update so that removing a booking removes its baggage records automatically.

### FlightDelayLog
Stores delay records linked to flights. Each record has a surrogate primary key (`delay_id`), a reason, a duration in minutes, a recorded datetime, and a foreign key to `Flight`. Cascades on delete and update so that removing a flight removes its delay records.

---

## Existing Tables Modified

### Flight
Two new foreign key columns were added to the `Flight` table:

- **`airline_id`** — References `Airline.airline_id`. Marked NOT NULL because every flight must be operated by a known airline. The referential action on delete is `NO ACTION` (RESTRICT): an airline cannot be deleted while it still has flights assigned to it. This protects operational history and prevents accidental data loss.
- **`gate_id`** — References `Gate.gate_id`. Allows NULL because a flight may be created in the system before a gate is assigned. The referential action on delete is `SET NULL`: if a gate record is removed, the flight's gate assignment simply becomes unknown rather than the flight record being deleted or blocked. This is the safer choice for an operational attribute that can legitimately be absent.

Because the `Flight` table already contained rows at the time of this change request, the `airline_id` column must be added in two steps in practice: first add it as nullable, populate existing rows with a valid airline, then apply the NOT NULL constraint. This avoids a constraint violation on existing data.

---

## Referential Action Justification

| Foreign Key | On Delete | On Update | Reasoning |
|---|---|---|---|
| `Baggage.booking_id → Booking` | CASCADE | CASCADE | Baggage has no meaning without its booking; removing a booking should clean up its baggage |
| `FlightDelayLog.flight_id → Flight` | CASCADE | CASCADE | Delay records are subordinate to the flight; they should not outlive it |
| `Flight.airline_id → Airline` | NO ACTION | CASCADE | An airline with active flights must not be deleted; updates to airline ID propagate |
| `Flight.gate_id → Gate` | SET NULL | CASCADE | If a gate is removed, the flight's gate assignment becomes unknown rather than blocking the deletion |
