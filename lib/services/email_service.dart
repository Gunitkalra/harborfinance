import 'package:url_launcher/url_launcher.dart';

class EmailService {
  static Future<bool> sendLeadEmail({
    required String name,
    required String email,
    required String phone,
    required String destination,
    required String message,
  }) async {
    final String subject = Uri.encodeComponent("New Overseas Loan Lead: $name");
    final String body = Uri.encodeComponent(
      "Dear Harbor Finance Team,\n\n"
      "A new student has requested a free consultation call. Here are their profiling details:\n\n"
      "• Name: $name\n"
      "• Email: $email\n"
      "• Phone: $phone\n"
      "• Target Destination: $destination\n"
      "• Message/Notes: $message\n\n"
      "Please reach out to the student within 4 business hours to evaluate their university admission and recommend matching banks.\n\n"
      "Sent from Harbor Finance Portal."
    );

    final Uri mailtoUri = Uri.parse(
      "mailto:gunit.kalra@harborfintech.com?subject=$subject&body=$body",
    );

    try {
      if (await canLaunchUrl(mailtoUri)) {
        return await launchUrl(mailtoUri);
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
