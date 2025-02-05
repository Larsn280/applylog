import 'package:applylog/models/application_data.dart';
import 'package:applylog/services/application_service.dart';
import 'package:applylog/widgets/custom_app_container.dart';
import 'package:applylog/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class DisplayApplicationsScreen extends StatefulWidget {
  const DisplayApplicationsScreen({super.key});

  @override
  State<DisplayApplicationsScreen> createState() =>
      _DisplayApplicationScreenState();
}

class _DisplayApplicationScreenState extends State<DisplayApplicationsScreen> {
  late ApplicationService _logApplicationService;
  late Future<List<ApplicationData>> _allApplyLogEntrys;

  @override
  void initState() {
    super.initState();
    _logApplicationService = ApplicationService();
    _allApplyLogEntrys = fetchAllLoggedEntrys();
  }

  Future<List<ApplicationData>> fetchAllLoggedEntrys() async {
    try {
      final response =
          await _logApplicationService.fetchAllLoggedApplications();

      if (response.isNotEmpty) {
        return response;
      } else {
        throw Exception('Failed to load applications...');
      }
    } catch (e) {
      print('Exception: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppContainer(
      titleText: 'Sökta Tjänster',
      child: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, '/logapplicationScreen');
                },
                text: 'Logga Tjänster',
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Container(
            constraints: BoxConstraints(
              maxHeight: 400,
            ),
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: FutureBuilder<List<ApplicationData>>(
              future: _allApplyLogEntrys,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No applications found.'));
                } else {
                  List<ApplicationData> logs = snapshot.data!;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: logs.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 16.0),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  logs[index].appliedJob ?? 'No Job',
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.white),
                                ),
                                Text(
                                  logs[index].timestamp ?? 'No Timestamp',
                                  style: TextStyle(
                                      fontSize: 13.0, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
