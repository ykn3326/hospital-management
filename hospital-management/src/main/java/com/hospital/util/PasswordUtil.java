package com.hospital.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Small wrapper around jBCrypt so the rest of the codebase never
 * touches plain-text passwords or the hashing library directly.
 */
public class PasswordUtil {

    public static String hash(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(10));
    }

    public static boolean verify(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }
}
