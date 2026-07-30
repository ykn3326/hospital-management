package com.hospital.model;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.Test;

class DoctorTest {

    @Test
    void gettersAndSettersShouldPreserveValues() {
        Doctor doctor = new Doctor();
        BigDecimal fee = new BigDecimal("150.00");

        doctor.setDoctorId(5);
        doctor.setName("Dr. Smith");
        doctor.setEmail("smith@example.com");
        doctor.setPasswordHash("hashedPwd");
        doctor.setSpecialization("Cardiology");
        doctor.setPhone("555-0200");
        doctor.setConsultationFee(fee);

        assertEquals(5, doctor.getDoctorId());
        assertEquals("Dr. Smith", doctor.getName());
        assertEquals("smith@example.com", doctor.getEmail());
        assertEquals("hashedPwd", doctor.getPasswordHash());
        assertEquals("Cardiology", doctor.getSpecialization());
        assertEquals("555-0200", doctor.getPhone());
        assertEquals(fee, doctor.getConsultationFee());
    }

    @Test
    void constructorShouldInitializeProperties() {
        BigDecimal fee = new BigDecimal("200.50");
        Doctor doctor = new Doctor(9, "Dr. Green", "green@example.com", "Dermatology", "555-0300", fee);

        assertEquals(9, doctor.getDoctorId());
        assertEquals("Dr. Green", doctor.getName());
        assertEquals("green@example.com", doctor.getEmail());
        assertEquals("Dermatology", doctor.getSpecialization());
        assertEquals("555-0300", doctor.getPhone());
        assertEquals(fee, doctor.getConsultationFee());
    }
}
