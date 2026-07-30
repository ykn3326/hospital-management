package com.hospital.model;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.Test;

class BillTest {

    @Test
    void gettersAndSettersShouldPreserveValues() {
        Bill bill = new Bill();
        BigDecimal consultationFee = new BigDecimal("100.00");
        BigDecimal medicineCharges = new BigDecimal("25.50");
        BigDecimal totalAmount = new BigDecimal("125.50");

        bill.setBillId(15);
        bill.setAppointmentId(77);
        bill.setConsultationFee(consultationFee);
        bill.setMedicineCharges(medicineCharges);
        bill.setTotalAmount(totalAmount);
        bill.setPaymentStatus("PAID");

        assertEquals(15, bill.getBillId());
        assertEquals(77, bill.getAppointmentId());
        assertEquals(consultationFee, bill.getConsultationFee());
        assertEquals(medicineCharges, bill.getMedicineCharges());
        assertEquals(totalAmount, bill.getTotalAmount());
        assertEquals("PAID", bill.getPaymentStatus());
    }
}
