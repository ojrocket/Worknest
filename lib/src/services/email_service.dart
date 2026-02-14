import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailService {
  // Replace with your actual EmailJS Service ID, Template ID, and User ID
  static const String _serviceId = 'YOUR_SERVICE_ID';
  static const String _templateId = 'YOUR_TEMPLATE_ID';
  static const String _userId = 'YOUR_USER_ID';

  static Future<void> sendOtpEmail(String recipientEmail, String otp) async {
    final String subject = '🔐 Verify Your WorkNest Identity';
    final String aiGeneratedBody = _generateAiTemplate(otp);

    // Simulation for demo purposes (logs the "AI Generated" email)
    print('--- [Simulating Email Send] ---');
    print('To: $recipientEmail');
    print('Subject: $subject');
    print('Body:\n$aiGeneratedBody');
    print('-------------------------------');

    // HTTP Request Logic (Uncomment to use with real EmailJS account)
    /*
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    try {
      final response = await http.post(
        url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': _serviceId,
          'template_id': _templateId,
          'user_id': _userId,
          'template_params': {
            'to_email': recipientEmail,
            'otp_code': otp,
            'message_html': aiGeneratedBody,
          },
        }),
      );
      if (response.statusCode != 200) {
        print('Failed to send email: ${response.body}');
      }
    } catch (e) {
      print('Error sending email: $e');
    }
    */
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
  }

  static String _generateAiTemplate(String otp) {
    return '''
<!DOCTYPE html>
<html>
<head>
<style>
  body { font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; background-color: #f4f7f6; color: #333; padding: 20px; }
  .container { max-width: 600px; margin: 0 auto; background: #ffffff; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
  .header { background: linear-gradient(135deg, #3F51B5 0%, #7986CB 100%); padding: 30px; text-align: center; }
  .header h1 { margin: 0; color: white; font-size: 24px; letter-spacing: 1px; }
  .content { padding: 40px 30px; text-align: center; }
  .otp-code { background: #E8EAF6; color: #3F51B5; font-size: 36px; font-weight: bold; letter-spacing: 5px; padding: 15px 30px; border-radius: 8px; display: inline-block; margin: 20px 0; border: 2px dashed #C5CAE9; }
  .message { font-size: 16px; line-height: 1.6; color: #555; margin-bottom: 25px; }
  .footer { background: #fafafa; padding: 20px; text-align: center; font-size: 12px; color: #999; border-top: 1px solid #eee; }
</style>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1>WorkNest Security</h1>
    </div>
    <div class="content">
      <p class="message">
        Hello,<br><br>
        Our AI security systems initiated a verification request for your account. 
        Please use the One-Time Password (OTP) below to complete your login. 
        This code is valid for 10 minutes.
      </p>
      <div class="otp-code">$otp</div>
      <p class="message" style="font-size: 14px; margin-top: 30px;">
        Determined to act? If you did not request this code, please ignore this email or contact support.
      </p>
    </div>
    <div class="footer">
      &copy; 2026 WorkNest Inc using Intelligent Security.<br>
      Automated by WorkNest AI.
    </div>
  </div>
</body>
</html>
    ''';
  }
}
