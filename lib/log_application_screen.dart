import 'package:applylog/app_constants.dart';
import 'package:applylog/widgets/custom_search_dropdownlist.dart';
import 'package:flutter/material.dart';

class LogApplicationScreen extends StatefulWidget {
  const LogApplicationScreen({super.key});

  @override
  State<LogApplicationScreen> createState() => _LogApplicationScreen();
}

class _LogApplicationScreen extends State<LogApplicationScreen> {
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

  String? _companyError;
  String? _appliedJobError;
  String? _locationError;
  String? _adSourceError;
  String? _contactError;
  String? _phoneError;
  String? _emailError;
  String? _dateError;
  String? _referenceError;
  String? _applystatusError;
  String? _adlinkError;
  String? _companysiteError;
  String? _commentsError;

  bool _isValidated() {
    setState(() {
      if (_companyController.text.isEmpty) {
        _companyError = 'Vänligen ange ett företag.';
      } else if (_companyController.text.length < 2) {
        _companyError = 'Vänligen ange minst två bokstäver.';
      }

      if (_appliedJobController.text.isEmpty) {
        _appliedJobError = 'Vänligen ange en tjänst.';
      } else if (_appliedJobController.text.length < 2) {
        _appliedJobError = 'Vänligen ange minst två bokstäver.';
      }

      if (_locationController.text.isEmpty) {
        _locationError = 'Vänligen ange plats.';
      } else if (_locationController.text.length < 2) {
        _locationError = 'Vänligen ange minst två bokstäver.';
      }

      if (_adSourceController.text.isEmpty) {
        _adSourceError = 'Vänligen ange var du såg annonsen.';
      } else if (_adSourceController.text.length < 2) {
        _adSourceError = 'Vänligen ange minst två bokstäver.';
      }
    });
    return _companyError == null &&
        _appliedJobError == null &&
        _locationError == null &&
        _adSourceError == null;
  }

  void _saveApplicationData() {
    try {
      if (_isValidated() == true) {}
    } catch (e) {
      throw Exception('Failed to save data... $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppConstants.buildMainContainer(
      titleText: 'Logga sökt tjänst',
      context: context,
      child: Column(
        children: [
          const SizedBox(
            height: 50.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                CustomSearchDropdownList(
                  controller: _adSourceController,
                  hintText: 'Var såg du annonsen?',
                  onErrorChanged: (newError) {
                    setState(() {
                      _adSourceError = newError;
                    });
                  },
                  errorMessage: _adSourceError,
                ),
                CustomSearchDropdownList(
                  controller: _companyController,
                  hintText: 'Företag',
                  onErrorChanged: (newError) {
                    setState(() {
                      _companyError = newError;
                    });
                  },
                  errorMessage: _companyError,
                ),
                CustomSearchDropdownList(
                    controller: _appliedJobController,
                    hintText: 'Sökt tjänst',
                    onErrorChanged: (newError) {
                      setState(() {
                        _appliedJobError = newError;
                      });
                    },
                    errorMessage: _appliedJobError),
                CustomSearchDropdownList(
                    controller: _locationController,
                    hintText: 'Plats',
                    onErrorChanged: (newError) {
                      setState(() {
                        _locationError = newError;
                      });
                    },
                    errorMessage: _locationError),
                CustomSearchDropdownList(
                    controller: _contactController,
                    hintText: 'Kontaktperson (valfri)',
                    onErrorChanged: (newError) {
                      setState(() {
                        _contactError = newError;
                      });
                    },
                    errorMessage: _contactError),
                CustomSearchDropdownList(
                    controller: _phoneController,
                    hintText: 'Telefon (valfri)',
                    onErrorChanged: (newError) {
                      setState(() {
                        _phoneError = newError;
                      });
                    },
                    errorMessage: _phoneError),
                CustomSearchDropdownList(
                    controller: _emailController,
                    hintText: 'Email (valfri)',
                    onErrorChanged: (newError) {
                      setState(() {
                        _emailError = newError;
                      });
                    },
                    errorMessage: _emailError),
                CustomSearchDropdownList(
                    controller: _dateController,
                    hintText: 'Datum då du såg annonsen (valfri)',
                    onErrorChanged: (newError) {
                      setState(() {
                        _dateError = newError;
                      });
                    },
                    errorMessage: _dateError),
                CustomSearchDropdownList(
                    controller: _referenceController,
                    hintText: 'Referensnummer (valfri)',
                    onErrorChanged: (newError) {
                      setState(() {
                        _referenceError = newError;
                      });
                    },
                    errorMessage: _referenceError),
                CustomSearchDropdownList(
                    controller: _applystatusController,
                    hintText: 'Ansökningstatus (valfri)',
                    onErrorChanged: (newError) {
                      setState(() {
                        _applystatusError = newError;
                      });
                    },
                    errorMessage: _applystatusError),
                CustomSearchDropdownList(
                    controller: _adlinkController,
                    hintText: 'Länk till annonsen (valfri)',
                    onErrorChanged: (newError) {
                      setState(() {
                        _adlinkError = newError;
                      });
                    },
                    errorMessage: _adlinkError),
                CustomSearchDropdownList(
                    controller: _companysiteController,
                    hintText: 'Företagets webbsida (valfri)',
                    onErrorChanged: (newError) {
                      setState(() {
                        _companysiteError = newError;
                      });
                    },
                    errorMessage: _companysiteError),
                CustomSearchDropdownList(
                    controller: _commentsController,
                    hintText: 'Övriga kommentarer (valfri)',
                    onErrorChanged: (newError) {
                      setState(() {
                        _commentsError = newError;
                      });
                    },
                    errorMessage: _commentsError),
                const SizedBox(
                  height: 12.0,
                ),
                ElevatedButton(
                    onPressed: () {
                      _isValidated();
                    },
                    child: Text('Spara'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
