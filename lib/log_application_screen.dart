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
  bool _startValidation = false;
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
    }
    return null;
  }

  void _clearAllFields() {
    setState(() {
      _startValidation = false; // Reset validation state
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
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

        _adSourceKey.currentState?.reset();
        _companyKey.currentState?.reset();
        _appliedJobKey.currentState?.reset();
        _locationKey.currentState?.reset();
      });
    });
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

  void _saveApplicationData() {
    if (!_validateAllFields()) return;
    try {} catch (e) {
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
                          return _validateField('annonsen', value ?? '');
                        },
                        fieldKey: _adSourceKey,
                        startValidation: _startValidation,
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
                      CustomTextFormField(
                        controller: _appliedJobController,
                        hintText: 'Sökt tjänst',
                        validator: (value) {
                          return _validateField('tjänst', value ?? '');
                        },
                        fieldKey: _appliedJobKey,
                        startValidation: _startValidation,
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
