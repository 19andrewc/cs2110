/**
 * CS 2110 Fall 2021 HW1
 * Part 2 - Coding with bases
 *
 * @author Austin Peng
 *
 * Global rules for this file:
 * - You may not use more than 2 conditionals per method. Conditionals are
 *   if-statements, if-else statements, or ternary expressions. The else block
 *   associated with an if-statement does not count toward this sum.
 * - You may not use more than 2 looping constructs per method. Looping
 *   constructs include for loops, while loops and do-while loops.
 * - You may not use nested loops.
 * - You may not declare any file-level variables.
 * - You may not use switch statements.
 * - You may not use the unsigned right shift operator (>>>)
 * - You may not write any helper methods, or call any method from this or
 *   another file to implement any method. Recursive solutions are not
 *   permitted.
 * - The only Java API methods you are allowed to invoke are:
 *     String.length()
 *     String.charAt()
 * - You may not invoke the above methods from string literals.
 *     Example: "12345".length()
 * - When concatenating numbers with Strings, you may only do so if the number
 *   is a single digit.
 *
 * Method-specific rules for this file:
 * - You may not use multiplication, division or modulus in any method, EXCEPT
 *   decimalStringToInt (where you may use multiplication only)
 * - You may declare exactly one String variable each in intToHexString and
 *   and binaryStringToOctalString.
 */
public class Bases
{
    /**
     * Convert a string containing ASCII characters (in binary) to an int.
     *
     * You do not need to handle negative numbers. The Strings we will pass in
     * will be valid binary numbers, and able to fit in a 32-bit signed integer.
     *
     * Example: binaryStringToInt("111"); // => 7
     */
    public static int binaryStringToInt(String binary)
    {
        // int result = 0;
        // int exp = 0;
        // for (int i = binary.length() - 1; i >= 0; i--) {
        //     int digit = binary.charAt(i) - '0';
        //     if (digit == 1) {
        //         result += (1 << exp);
        //     }
        //     exp++;
        // }
        // return result;
        int result = 0;
        int shift = 0;
        for (int i = binary.length() - 1; i >= 0; i--) {
            char temp = binary.charAt(i);
            result += (temp << shift) & (1 << shift);
            shift++;
        }
        return result;
    }

    /**
     * Convert a string containing ASCII characters (in decimal) to an int.
     *
     * You do not need to handle negative numbers. The Strings we will pass in
     * will be valid decimal numbers, and able to fit in a 32-bit signed integer.
     *
     * Example: decimalStringToInt("46"); // => 46
     *
     * You may use multiplication in this method.
     */
    public static int decimalStringToInt(String decimal)
    {
        int result = 0;
        int place = 1;
        for (int i = decimal.length() - 1; i >= 0; i--) {
            result += (decimal.charAt(i) - '0') * place;
            place *= 10;
        }
        return result;
    }

    /**
     * Convert a string containing ASCII characters (in octal) to an int.
     *
     * You do not need to handle negative numbers. The Strings we will pass in
     * will be valid octal numbers, and able to fit in a 32-bit signed integer.
     *
     * Example: octalStringToInt("27"); // => 23
     */
    public static int octalStringToInt(String octal)
    {
        int result = 0;
        int shift = 0;
        for (int i = octal.length() - 1; i >= 0; i--) {
            char temp = octal.charAt(i);
            result += (temp << shift) & (07 << shift);
            shift += 3;
        }
        return result;
    }

    /**
     * Convert a int into a String containing ASCII characters (in hex).
     *
     * You do not need to handle negative numbers.
     * The String returned should contain the minimum number of characters
     * necessary to represent the number that was passed in.
     *
     * Example: intToHexString(166); // => "A6"
     *
     * You may declare one String variable in this method.
     */
    public static String intToHexString(int hex)
    {
        String hexString = "";
        if (hex == 0 && hexString.length() == 0) {
            return "0";
        }
        while (hex > 0) {
            if ((hex & 0xF) <= 9) {
                hexString = (char) ('0' + (hex & 0xF)) + hexString;
            } else {
                hexString = (char) ('A' + ((hex & 0xF) - 10)) + hexString;
            }
            hex = hex >> 4;
        }
        return hexString;
    }

    /**
     * Convert a String containing ASCII characters representing a number in
     * binary into a String containing ASCII characters that represent that same
     * value in octal.
     *
     * The output string should only contain numbers.
     * You do not need to handle negative numbers.
     * The length of all the binary strings passed in will be of size 24.
     * The octal string returned should contain 8 characters.
     *
     * Example: binaryStringToOctalString("000001101010000111100100"); // => "01520744"
     *
     * You may declare one String variable in this method.
     */
    public static String binaryStringToOctalString(String binary)
    {
        String octal = "";
        int b = 0;

        // to binary
        for (int i = binary.length() - 1; i >= 0; i--) {
            if (binary.charAt(i) == '1') {
                b = b | (1 << (binary.length() - i - 1));
            }
        }

        // binary to octal
        int count = 8;
        while (count != 0) {
            octal = (char) ('0' + (b & 07)) + octal;
            b = b >> 3;
            count--;
        }

        return octal;
    }
}
