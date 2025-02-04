import 'package:http/http.dart' as http;
import 'dart:convert';

class LogApplicationService {
  Future<http.Response> submitForm(
      String adSource,
      String company,
      String appliedJob,
      String location,
      String contact,
      String phone,
      String email,
      String date,
      String reference,
      String applyStatus,
      String adLink,
      String companySite,
      String comments) async {
    // final url = 'http://localhost:5110/api/ApplyLogEntry'; //Browser url
    final url = 'http://10.0.2.2:5110/api/ApplyLogEntry'; //Emulator url android
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'adSource': adSource,
          'company': company,
          'appliedJob': appliedJob,
          'location': location,
          'contact': contact,
          'phone': phone,
          'email': email,
          'date': date,
          'reference': reference,
          'applyStatus': applyStatus,
          'adLink': adLink,
          'companySite': companySite,
          'comments': comments,
          'timestamp': DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode == 201) {
        print('Form submitted successfully');
      } else {
        print('Failed to submit form: ${response.statusCode}');
        print('Response: ${response.body}');
      }

      return response; // Return response for further handling
    } catch (e) {
      print('Error submitting form: $e');
      throw Exception('Failed to submit form: $e');
    }
  }
}
