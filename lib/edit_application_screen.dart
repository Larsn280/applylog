import 'package:applylog/models/application_data.dart';
import 'package:applylog/services/application_service.dart';
import 'package:applylog/widgets/custom_app_container.dart';
import 'package:applylog/widgets/custom_button.dart';
import 'package:applylog/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class EditApplicationScreen extends StatefulWidget {
  final String applicationId;
  const EditApplicationScreen({super.key, required this.applicationId});

  @override
  State<EditApplicationScreen> createState() => _EditApplicationScreenState();
}

class _EditApplicationScreenState extends State<EditApplicationScreen> {
  bool _startValidation = false;
  final GlobalKey<FormFieldState> _adSourceKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _companyKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _appliedJobKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _locationKey = GlobalKey<FormFieldState>();

  String applicationId = '';
  final TextEditingController _adSourceController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _appliedJobController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _applystatusController = TextEditingController();
  final TextEditingController _adlinkController = TextEditingController();
  final TextEditingController _companysiteController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();

  late ApplicationService _applicationService;
  late Future<ApplicationData> _applicationData;

  @override
  void initState() {
    super.initState();
    _applicationService = ApplicationService();
    _applicationData = _fetchApplicationData();
  }

  @override
  void dispose() {
    _adSourceController.dispose();
    _companyController.dispose();
    _appliedJobController.dispose();
    _locationController.dispose();
    _contactController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _dateController.dispose();
    _referenceController.dispose();
    _applystatusController.dispose();
    _adlinkController.dispose();
    _companysiteController.dispose();
    _commentsController.dispose();
    super.dispose();
  }

  void _setControllerTexts(ApplicationData applicationData) {
    applicationId = applicationData.sk!;
    _adSourceController.text = applicationData.adSource!;
    _companyController.text = applicationData.company!;
    _appliedJobController.text = applicationData.appliedJob!;
    _locationController.text = applicationData.location!;
    _contactController.text = applicationData.contact!;
    _phoneController.text = applicationData.phone!;
    _emailController.text = applicationData.email!;
    _dateController.text = applicationData.date!;
    _referenceController.text = applicationData.reference!;
    _applystatusController.text = applicationData.applyStatus!;
    _adlinkController.text = applicationData.adLink!;
    _companysiteController.text = applicationData.companySite!;
    _commentsController.text = applicationData.comments!;
  }

  String? _validateField(String fieldName, String value) {
    if (value.isEmpty) {
      return 'Vänligen ange $fieldName.';
    }
    return null;
  }

  bool _validateAllFields() {
    setState(() {
      _startValidation = true;
    });

    return [
      _adSourceKey.currentState?.validate(),
      _companyKey.currentState?.validate(),
      _appliedJobKey.currentState?.validate(),
      _locationKey.currentState?.validate(),
    ].every((result) => result ?? false);
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

  Future<void> _saveUpdatedApplicationData() async {
    if (!_validateAllFields()) return;

    try {
      final updatedApplication = ApplicationData(
        pk: "",
        sk: applicationId,
        adSource: _adSourceController.text,
        company: _companyController.text,
        appliedJob: _appliedJobController.text,
        location: _locationController.text,
        contact: _contactController.text,
        phone: _phoneController.text,
        email: _emailController.text,
        date: _dateController.text,
        reference: _referenceController.text,
        applyStatus: _applystatusController.text,
        adLink: _adlinkController.text,
        companySite: _companysiteController.text,
        comments: _commentsController.text,
      );

      final response =
          await _applicationService.updateApplication(updatedApplication);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.of(context).pop(true);
      } else {
        throw Exception(
            "Failed to save data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppContainer(
      titleText: 'Ändra Ansökning',
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
                  _setControllerTexts(application);
                  return ListView(
                    children: [
                      Column(
                        children: [
                          CustomTextFormField(
                            controller: _adSourceController,
                            hintText: 'Var såg du annonsen?',
                            validator: (value) {
                              return _validateField('annonsen', value ?? '');
                            },
                            fieldKey: _adSourceKey,
                            startValidation: _startValidation,
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          CustomTextFormField(
                            controller: _companyController,
                            hintText: 'Företag',
                            validator: (value) {
                              return _validateField('företag', value ?? '');
                            },
                            fieldKey: _companyKey,
                            startValidation: _startValidation,
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          CustomTextFormField(
                            controller: _appliedJobController,
                            hintText: 'Sökt tjänst',
                            validator: (value) {
                              return _validateField('tjänst', value ?? '');
                            },
                            fieldKey: _appliedJobKey,
                            startValidation: _startValidation,
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          CustomTextFormField(
                            controller: _locationController,
                            hintText: 'Plats',
                            validator: (value) {
                              return _validateField('plats', value ?? '');
                            },
                            fieldKey: _locationKey,
                            startValidation: _startValidation,
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          CustomTextFormField(
                            controller: _contactController,
                            hintText: 'Kontaktperson (valfri)',
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          CustomTextFormField(
                            controller: _phoneController,
                            hintText: 'Telefon (valfri)',
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          CustomTextFormField(
                            controller: _emailController,
                            hintText: 'Email (valfri)',
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          CustomTextFormField(
                            controller: _dateController,
                            hintText: 'Datum då du såg annonsen (valfri)',
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          CustomTextFormField(
                            controller: _referenceController,
                            hintText: 'Referensnummer (valfri)',
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          CustomTextFormField(
                            controller: _applystatusController,
                            hintText: 'Ansökningstatus (valfri)',
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          CustomTextFormField(
                            controller: _adlinkController,
                            hintText: 'Länk till annonsen (valfri)',
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          CustomTextFormField(
                            controller: _companysiteController,
                            hintText: 'Företagets webbsida (valfri)',
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          CustomTextFormField(
                            controller: _commentsController,
                            hintText: 'Övriga kommentarer (valfri)',
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomButton(
                                  text: 'Avbryt',
                                  onPressed: _saveUpdatedApplicationData),
                              CustomButton(
                                  text: 'Spara',
                                  onPressed: _saveUpdatedApplicationData),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          )
                        ],
                      ),
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
