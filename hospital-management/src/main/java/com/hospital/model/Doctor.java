package com.hospital.model;

import java.math.BigDecimal;

public class Doctor {
    private int doctorId;
    private String name;
    private String email;
    private String passwordHash;
    private String specialization;
    private String phone;
    private BigDecimal consultationFee;

    public Doctor() {}

    public Doctor(int doctorId, String name, String email, String specialization, String phone, BigDecimal consultationFee) {
        this.doctorId = doctorId;
        this.name = name;
        this.email = email;
        this.specialization = specialization;
        this.phone = phone;
        this.consultationFee = consultationFee;
    }

    public int getDoctorId() { return doctorId; }
    public void setDoctorId(int doctorId) { this.doctorId = doctorId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }

    public String getSpecialization() { return specialization; }
    public void setSpecialization(String specialization) { this.specialization = specialization; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public BigDecimal getConsultationFee() { return consultationFee; }
    public void setConsultationFee(BigDecimal consultationFee) { this.consultationFee = consultationFee; }
}
