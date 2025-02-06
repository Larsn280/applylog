import 'package:applylog/models/application_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApplicationService {
  final String baseUrl = dotenv.env['DEVELOPMENT_ANDROID_EMULATOR_BASE_URL'] ??
      (throw Exception(
          "DEVELOPMENT_ANDROID_EMULATOR_BASE_URL is missing in .env"));

  Future<List<ApplicationData>> fetchAllApplications() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> responseList = jsonDecode(response.body);
        List<ApplicationData> applications = responseList
            .map((application) => ApplicationData.fromJson(application))
            .toList();
        return applications;
      } else {
        print('Failed to fetch logs: ${response.statusCode}');
        print('Response: ${response.body}');
      }

      return [];
    } catch (e) {
      print('Error fetching logs: $e');
      throw Exception('Failed to fetch logs: $e');
    }
  }

  Future<ApplicationData> fetchApplicationById(int applicationId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$applicationId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        dynamic applicationData = jsonDecode(response.body);
        return ApplicationData.fromJson(applicationData);
      } else {
        throw Exception(
            'Failed to fetch applicationData: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch applicationData: $e');
    }
  }

  Future<http.Response> postApplication(ApplicationData data) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'adSource': data.adSource,
          'company': data.company,
          'appliedJob': data.appliedJob,
          'location': data.location,
          'contact': data.contact,
          'phone': data.phone,
          'email': data.email,
          'date': data.date,
          'reference': data.reference,
          'applyStatus': data.applyStatus,
          'adLink': data.adLink,
          'companySite': data.companySite,
          'comments': data.comments,
          'timestamp': DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode == 201) {
        print('Posted application successfully');
      } else {
        print('Failed to post application: ${response.statusCode}');
        print('Response: ${response.body}');
      }

      return response;
    } catch (e) {
      print('Error posting application: $e');
      throw Exception('Failed to post application: $e');
    }
  }

  Future<bool> removeApplication(int applicationId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$applicationId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 204) {
        return true;
      } else {
        throw Exception('Failed to delete application: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete application: $e');
    }
  }
}
