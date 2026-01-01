import 'dart:math';

class OtpUtils {
  static String generateOtp() {
    return (1000 + Random().nextInt(9000)).toString();
  }
}
