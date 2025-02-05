import 'package:applylog/models/application_data.dart';
import 'package:applylog/services/application_service.dart';
import 'package:applylog/widgets/custom_app_container.dart';
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
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, '/logapplicationScreen');
                },
                child: Text('Logga Tjänster'),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Container(
            constraints: BoxConstraints(
              maxHeight: 400, // Set your max height here
            ),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
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
                    shrinkWrap:
                        true, // Allow ListView to take only needed space
                    itemCount: logs.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 2.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              logs[index].appliedJob ?? 'No Job',
                              style: TextStyle(fontSize: 15.0),
                            ),
                            Text(
                              logs[index].timestamp ?? 'No Timestamp',
                              style: TextStyle(fontSize: 13.0),
                            ),
                          ],
                        ),
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
