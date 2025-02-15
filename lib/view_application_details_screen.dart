import 'package:applylog/edit_application_screen.dart';
import 'package:applylog/models/application_data.dart';
import 'package:applylog/services/application_service.dart';
import 'package:applylog/widgets/custom_app_container.dart';
import 'package:flutter/material.dart';

class ViewApplicationDetailsScreen extends StatefulWidget {
  final String applicationId;

  const ViewApplicationDetailsScreen({super.key, required this.applicationId});

  @override
  State<ViewApplicationDetailsScreen> createState() =>
      _ViewApplicationDetailsScreenState();
}

class _ViewApplicationDetailsScreenState
    extends State<ViewApplicationDetailsScreen> {
  late ApplicationService _applicationService;
  late Future<ApplicationData> _applicationData;

  @override
  void initState() {
    super.initState();
    _applicationService = ApplicationService();
    _applicationData = _fetchApplicationData();
  }

  Future<ApplicationData> _fetchApplicationData() async {
    try {
      final response =
          await _applicationService.fetchApplicationById(widget.applicationId);
      return response;
    } catch (e) {
      throw Exception('Failed to fetch applicationData: $e');
    }
  }

  Future<void> _removeApplication(String applicationId) async {
    // Show the confirmation dialog
    bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Är du säker?'),
          content: Text('Vill du verkligen ta bort ansökningen?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(false); // Close the dialog and return false (cancel)
              },
              child: Text('Nej'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(true); // Close the dialog and return true (confirm)
              },
              child: Text('Ja'),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      bool success = await _applicationService.removeApplication(applicationId);
      if (success) {
        Navigator.of(context).pop(true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Misslyckade med att ta bort ansökningen')));
      }
    }
  }

  void _navigateToEditScreen(BuildContext context, String applicationId) async {
    final respose = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditApplicationScreen(
                  applicationId: applicationId,
                )));

    if (respose == true) {
      setState(() {
        _applicationData = _fetchApplicationData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppContainer(
      titleText: 'Info om Tjänst',
      child: Column(
        children: [
          const SizedBox(
            height: 72.0,
          ),
          Container(
            width: double.infinity,
            constraints: BoxConstraints(maxHeight: 400),
            decoration: BoxDecoration(color: Colors.white),
            padding: EdgeInsets.all(20.0),
            child: FutureBuilder<ApplicationData>(
              future: _applicationData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.black,
                  ));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final application = snapshot.data!;
                  return ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${application.appliedJob}',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    _navigateToEditScreen(
                                        context, application.sk);
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                  )),
                              IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    _removeApplication(application.sk);
                                  }),
                            ],
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text('${application.date}'),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text('Status ansökning: ${application.applyStatus}'),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text('Företag: ${application.company}'),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text('Webbsida: ${application.companySite}'),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text('Annonskälla: ${application.adSource}'),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text('Referens nummer: ${application.reference}'),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text('Annonslänk: ${application.adLink}'),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text('Plats: ${application.location}'),
                          const SizedBox(
                            height: 40.0,
                          ),
                          Text('Kontakperson: ${application.contact}'),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text('Telefon: ${application.phone}'),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text('Email: ${application.email}'),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          Text('Övriga kommentarer: ${application.comments}'),
                        ],
                      )
                    ],
                  );
                } else {
                  return Center(child: Text('No data available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
