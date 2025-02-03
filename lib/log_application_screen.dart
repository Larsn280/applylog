import 'package:applylog/widgets/custom_app_container.dart';
import 'package:applylog/widgets/custom_button.dart';
import 'package:applylog/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class LogApplicationScreen extends StatefulWidget {
  const LogApplicationScreen({super.key});

  @override
  State<LogApplicationScreen> createState() => _LogApplicationScreen();
}

class _LogApplicationScreen extends State<LogApplicationScreen> {
  final GlobalKey<FormFieldState> _adSourceKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _companyKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _appliedJobKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _locationKey = GlobalKey<FormFieldState>();

  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _appliedJobController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _adSourceController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _applystatusController = TextEditingController();
  final TextEditingController _adlinkController = TextEditingController();
  final TextEditingController _companysiteController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();

  String? _validateField(String fieldName, String value) {
    if (value.isEmpty) {
      return 'Vänligen ange $fieldName.';
    } else if (value.length < 2) {
      return 'Ange minst två tecken för $fieldName.';
    }
    return null;
  }

  void _clearAllFields() {
    setState(() {
      _companyController.clear();
      _appliedJobController.clear();
      _locationController.clear();
      _adSourceController.clear();
      _contactController.clear();
      _phoneController.clear();
      _emailController.clear();
      _dateController.clear();
      _referenceController.clear();
      _applystatusController.clear();
      _adlinkController.clear();
      _companysiteController.clear();
      _commentsController.clear();
    });
    _adSourceKey.currentState?.reset();
    _companyKey.currentState?.reset();
    _appliedJobKey.currentState?.reset();
    _locationKey.currentState?.reset();
  }

  bool _validateAllFields() {
    // Collect the validation results for each field
    List<bool> validationResults = [
      _adSourceKey.currentState?.validate() ?? false,
      _companyKey.currentState?.validate() ?? false,
      _appliedJobKey.currentState?.validate() ?? false,
      _locationKey.currentState?.validate() ?? false,
    ];

    // Return true only if all fields are valid
    return validationResults.every((result) => result == true);
  }

  void _saveApplicationData() {
    try {
      if (_validateAllFields()) {}
    } catch (e) {
      throw Exception('Failed to save data... $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppContainer(
      titleText: 'Logga sökt tjänst',
      child: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(text: 'Rensa fält', onPressed: _clearAllFields),
            ],
          ),
          const SizedBox(
            height: 12.0,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0)),
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: _adSourceController,
                        hintText: 'Var såg du annonsen?',
                        validator: (value) {
                          return _validateField(
                              'annonsen', _adSourceController.text);
                        },
                        fieldKey: _adSourceKey,
                      ),
                      CustomTextFormField(
                        controller: _companyController,
                        hintText: 'Företag',
                        validator: (value) {
                          return _validateField(
                              'företag', _companyController.text);
                        },
                        fieldKey: _companyKey,
                      ),
                      CustomTextFormField(
                        controller: _appliedJobController,
                        hintText: 'Sökt tjänst',
                        validator: (value) {
                          return _validateField(
                              'tjänst', _appliedJobController.text);
                        },
                        fieldKey: _appliedJobKey,
                      ),
                      CustomTextFormField(
                        controller: _locationController,
                        hintText: 'Plats',
                        validator: (value) {
                          return _validateField(
                              'plats', _locationController.text);
                        },
                        fieldKey: _locationKey,
                      ),
                      CustomTextFormField(
                        controller: _contactController,
                        hintText: 'Kontaktperson (valfri)',
                      ),
                      CustomTextFormField(
                        controller: _phoneController,
                        hintText: 'Telefon (valfri)',
                      ),
                      CustomTextFormField(
                        controller: _emailController,
                        hintText: 'Email (valfri)',
                      ),
                      CustomTextFormField(
                        controller: _dateController,
                        hintText: 'Datum då du såg annonsen (valfri)',
                      ),
                      CustomTextFormField(
                        controller: _referenceController,
                        hintText: 'Referensnummer (valfri)',
                      ),
                      CustomTextFormField(
                        controller: _applystatusController,
                        hintText: 'Ansökningstatus (valfri)',
                      ),
                      CustomTextFormField(
                        controller: _adlinkController,
                        hintText: 'Länk till annonsen (valfri)',
                      ),
                      CustomTextFormField(
                        controller: _companysiteController,
                        hintText: 'Företagets webbsida (valfri)',
                      ),
                      CustomTextFormField(
                        controller: _commentsController,
                        hintText: 'Övriga kommentarer (valfri)',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(text: 'Avbryt', onPressed: _saveApplicationData),
              CustomButton(text: 'Spara', onPressed: _saveApplicationData),
            ],
          ),
          const SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
  }
}
