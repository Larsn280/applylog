import 'package:applylog/models/application_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApplicationService {
  final String baseUrl = dotenv.env['DEVELOPMENT_ANDROID_EMULATOR_BASE_URL'] ??
      (throw Exception(
          'DEVELOPMENT_ANDROID_EMULATOR_BASE_URL is missing in .env. Please check your .env file.'));

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
        List<ApplicationData> applicationsData = responseList
            .map((applicationData) => ApplicationData.fromJson(applicationData))
            .toList();
        return applicationsData;
      } else {
        throw Exception(
            'Error trying to fetch applicationsList: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error trying to fetch applicationsList: $e');
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
            'Error trying to fetch applicationData by ID: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error trying to fetch applicationData by ID: $e');
    }
  }

  Future<http.Response> postApplication(ApplicationData applicationData) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'adSource': applicationData.adSource,
          'company': applicationData.company,
          'appliedJob': applicationData.appliedJob,
          'location': applicationData.location,
          'contact': applicationData.contact,
          'phone': applicationData.phone,
          'email': applicationData.email,
          'date': applicationData.date,
          'reference': applicationData.reference,
          'applyStatus': applicationData.applyStatus,
          'adLink': applicationData.adLink,
          'companySite': applicationData.companySite,
          'comments': applicationData.comments,
          'timestamp': DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode == 201) {
        print('Posted application successfully');
      } else {
        throw Exception('Error trying to post applicationData');
      }

      return response;
    } catch (e) {
      throw Exception('Error trying to post applicationData: $e');
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
        throw Exception(
            'Error trying to delete application: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error trying to delete application: $e');
    }
  }
}
