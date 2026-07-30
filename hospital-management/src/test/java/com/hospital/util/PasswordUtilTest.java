package com.hospital.util;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import org.junit.jupiter.api.Test;

class PasswordUtilTest {

    @Test
    void hashShouldReturnDifferentValueForSamePassword() {
        String plainPassword = "SafePassword123!";

        String hash1 = PasswordUtil.hash(plainPassword);
        String hash2 = PasswordUtil.hash(plainPassword);

        assertNotNull(hash1, "Hash should not be null");
        assertNotNull(hash2, "Hash should not be null");
        assertNotEquals(hash1, hash2, "BCrypt hashes should differ because of salt");
    }

    @Test
    void verifyShouldReturnTrueForMatchingPassword() {
        String plainPassword = "SafePassword123!";
        String hash = PasswordUtil.hash(plainPassword);

        assertTrue(PasswordUtil.verify(plainPassword, hash));
    }

    @Test
    void verifyShouldReturnFalseForNonMatchingPassword() {
        String plainPassword = "SafePassword123!";
        String wrongPassword = "WrongPassword!";
        String hash = PasswordUtil.hash(plainPassword);

        assertFalse(PasswordUtil.verify(wrongPassword, hash));
    }
}
