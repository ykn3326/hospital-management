package com.hospital.model;

import java.time.LocalDate;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.Test;

class PatientTest {

    @Test
    void gettersAndSettersShouldPreserveValues() {
        Patient patient = new Patient();
        LocalDate dob = LocalDate.of(1990, 5, 20);

        patient.setPatientId(42);
        patient.setName("Alice");
        patient.setEmail("alice@example.com");
        patient.setPasswordHash("hashedPwd");
        patient.setPhone("1234567890");
        patient.setGender("Female");
        patient.setDob(dob);
        patient.setAddress("123 Main St");

        assertEquals(42, patient.getPatientId());
        assertEquals("Alice", patient.getName());
        assertEquals("alice@example.com", patient.getEmail());
        assertEquals("hashedPwd", patient.getPasswordHash());
        assertEquals("1234567890", patient.getPhone());
        assertEquals("Female", patient.getGender());
        assertEquals(dob, patient.getDob());
        assertEquals("123 Main St", patient.getAddress());
    }

    @Test
    void constructorShouldInitializeProperties() {
        LocalDate dob = LocalDate.of(1985, 12, 1);
        Patient patient = new Patient(7, "Bob", "bob@example.com", "555-0100", "Male", dob, "456 Elm St");

        assertEquals(7, patient.getPatientId());
        assertEquals("Bob", patient.getName());
        assertEquals("bob@example.com", patient.getEmail());
        assertEquals("555-0100", patient.getPhone());
        assertEquals("Male", patient.getGender());
        assertEquals(dob, patient.getDob());
        assertEquals("456 Elm St", patient.getAddress());
    }
}
