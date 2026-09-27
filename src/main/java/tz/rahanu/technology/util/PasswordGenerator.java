package tz.rahanu.technology.util;

public class PasswordGenerator {

    public static void main(String[] args) {

        String password = "rahanu";

        String hash =
                PasswordUtil.hashPassword(password);

        System.out.println();
        System.out.println("Password: " + password);
        System.out.println("Hash:");
        System.out.println(hash);
        System.out.println();
    }
}
