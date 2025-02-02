import 'package:applylog/widgets/custom_app_container.dart';
import 'package:applylog/widgets/custom_button.dart';
import 'package:applylog/widgets/custom_search_dropdownlist.dart';
import 'package:flutter/material.dart';

class LogApplicationScreen extends StatefulWidget {
  const LogApplicationScreen({super.key});

  @override
  State<LogApplicationScreen> createState() => _LogApplicationScreen();
}

class _LogApplicationScreen extends State<LogApplicationScreen> {
  final _formKey = GlobalKey<FormState>();
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
      return 'Vänligen ange minst två bokstäver för $fieldName.';
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
    _formKey.currentState?.reset();
  }

  void _saveApplicationData() {
    try {
      if (_formKey.currentState?.validate() == true) {}
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
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8.0)),
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        CustomSearchDropdownList(
                          controller: _adSourceController,
                          hintText: 'Var såg du annonsen?',
                          validator: (value) {
                            return _validateField('var du såg annonsen',
                                _adSourceController.text);
                          },
                        ),
                        CustomSearchDropdownList(
                          controller: _companyController,
                          hintText: 'Företag',
                          validator: (value) {
                            return _validateField(
                                'ett företag', _companyController.text);
                          },
                        ),
                        CustomSearchDropdownList(
                          controller: _appliedJobController,
                          hintText: 'Sökt tjänst',
                          validator: (value) {
                            return _validateField(
                                'en tjänst', _appliedJobController.text);
                          },
                        ),
                        CustomSearchDropdownList(
                          controller: _locationController,
                          hintText: 'Plats',
                          validator: (value) {
                            return _validateField(
                                'en plats', _locationController.text);
                          },
                        ),
                        CustomSearchDropdownList(
                          controller: _contactController,
                          hintText: 'Kontaktperson (valfri)',
                        ),
                        CustomSearchDropdownList(
                          controller: _phoneController,
                          hintText: 'Telefon (valfri)',
                        ),
                        CustomSearchDropdownList(
                          controller: _emailController,
                          hintText: 'Email (valfri)',
                        ),
                        CustomSearchDropdownList(
                          controller: _dateController,
                          hintText: 'Datum då du såg annonsen (valfri)',
                        ),
                        CustomSearchDropdownList(
                          controller: _referenceController,
                          hintText: 'Referensnummer (valfri)',
                        ),
                        CustomSearchDropdownList(
                          controller: _applystatusController,
                          hintText: 'Ansökningstatus (valfri)',
                        ),
                        CustomSearchDropdownList(
                          controller: _adlinkController,
                          hintText: 'Länk till annonsen (valfri)',
                        ),
                        CustomSearchDropdownList(
                          controller: _companysiteController,
                          hintText: 'Företagets webbsida (valfri)',
                        ),
                        CustomSearchDropdownList(
                          controller: _commentsController,
                          hintText: 'Övriga kommentarer (valfri)',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
