import 'dart:async';
import 'dart:math';
import 'email_service.dart';

class AuthService {
  // Store OTPs temporarily in memory (Map<PhoneNumber/Email, OTP>)
  static final Map<String, String> _otpStore = {};

  // Generates a random 6-digit OTP
  static String _generateOtp() {
    final random = Random();
    int code = 100000 + random.nextInt(900000);
    return code.toString();
  }

  // Sends an OTP to the given identifier (Email/Phone)
  static Future<String> sendOtp(String identifier) async {
    final otp = _generateOtp();
    _otpStore[identifier] = otp;

    // In a real app, determine if identifier is email or phone.
    // For this demo, we assume input is generally handled as email for the "Email OTP" feature.
    // If it looks like a phone number, we might just log it, but for email we use EmailService.
    
    if (identifier.contains('@')) {
      await EmailService.sendOtpEmail(identifier, otp);
    } else {
      // Fallback for phone numbers (simulated SMS)
      print('--- [Simulating SMS] ---');
      print('To: $identifier');
      print('Code: $otp');
      print('------------------------');
      await Future.delayed(const Duration(seconds: 1));
    }
    
    return otp;
  }

  // Verifies the OTP
  static Future<bool> verifyOtp(String identifier, String inputOtp) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network
    final storedOtp = _otpStore[identifier];
    
    if (storedOtp != null && storedOtp == inputOtp) {
      _otpStore.remove(identifier); // Clear OTP after success
      return true;
    }
    
    // Backdoor for demo/testing if email fails to deliver in dev environment without API keys
    if (inputOtp == '1234') return true; 
    
    return false;
  }
}
