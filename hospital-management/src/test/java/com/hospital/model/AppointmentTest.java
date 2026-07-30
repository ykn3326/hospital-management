package com.hospital.model;

import java.time.LocalDate;
import java.time.LocalTime;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.Test;

class AppointmentTest {

    @Test
    void gettersAndSettersShouldPreserveValues() {
        Appointment appointment = new Appointment();
        LocalDate visitDate = LocalDate.of(2026, 8, 1);
        LocalTime visitTime = LocalTime.of(14, 30);

        appointment.setAppointmentId(11);
        appointment.setPatientId(22);
        appointment.setDoctorId(33);
        appointment.setVisitDate(visitDate);
        appointment.setVisitTime(visitTime);
        appointment.setStatus("BOOKED");
        appointment.setPatientName("Alice");
        appointment.setDoctorName("Dr. Smith");

        assertEquals(11, appointment.getAppointmentId());
        assertEquals(22, appointment.getPatientId());
        assertEquals(33, appointment.getDoctorId());
        assertEquals(visitDate, appointment.getVisitDate());
        assertEquals(visitTime, appointment.getVisitTime());
        assertEquals("BOOKED", appointment.getStatus());
        assertEquals("Alice", appointment.getPatientName());
        assertEquals("Dr. Smith", appointment.getDoctorName());
    }
}
