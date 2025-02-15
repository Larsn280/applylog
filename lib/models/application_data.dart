import 'package:intl/intl.dart';

class ApplicationData {
  String pk; // Primary Key
  String sk; // Sort Key
  String adSource;
  String company;
  String appliedJob;
  String location;
  String contact;
  String phone;
  String email;
  String date;
  String reference;
  String applyStatus;
  String adLink;
  String companySite;
  String comments;
  DateTime? timestamp;

  ApplicationData({
    required this.pk,
    required this.sk,
    required this.adSource,
    required this.company,
    required this.appliedJob,
    required this.location,
    required this.contact,
    required this.phone,
    required this.email,
    required this.date,
    required this.reference,
    required this.applyStatus,
    required this.adLink,
    required this.companySite,
    required this.comments,
    this.timestamp,
  });

  factory ApplicationData.fromJson(Map<String, dynamic> json) {
    return ApplicationData(
      pk: json['pk'] ?? '',
      sk: json['sk'] ?? '',
      adSource: json['adSource'] ?? '',
      company: json['company'] ?? '',
      appliedJob: json['appliedJob'] ?? '',
      location: json['location'] ?? '',
      contact: json['contact'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      date: json['date'] ?? '',
      reference: json['reference'] ?? '',
      applyStatus: json['applyStatus'] ?? '',
      adLink: json['adLink'] ?? '',
      companySite: json['companySite'] ?? '',
      comments: json['comments'] ?? '',
      timestamp:
          json['timestamp'] != null ? DateTime.parse(json['timestamp']) : null,
    );
  }

  // Optional: Method to format timestamp as a readable date string
  String get formattedTimestamp {
    return timestamp != null
        ? DateFormat('yyyy-MM-dd HH:mm').format(timestamp!)
        : 'N/A';
  }
}
