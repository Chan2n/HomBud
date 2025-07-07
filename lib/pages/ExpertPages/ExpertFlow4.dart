import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hombuddy/pages/ExpertPages/ExpertFlow5.dart';

class ExpertFlow4 extends StatefulWidget {
  final String expertId;
  final String fullName;

  const ExpertFlow4(
      {super.key, required this.expertId, required this.fullName});

  @override
  _ExpertFlow4State createState() => _ExpertFlow4State();
}

class _ExpertFlow4State extends State<ExpertFlow4> {
  String? _selectedExperience;
  String? _selectedService;
  final List<String> _selectedSpecializations = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showWelcomeBottomSheet(context);
    });
  }

  Future<void> _saveDataToFirestore() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    try {
      // Get the existing data from Firestore
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection('Expert')
              .doc(widget.expertId)
              .get();

      // Merge the existing data with the new data
      Map<String, dynamic> data = {
        'fullName': widget.fullName,
        'service': _selectedService,
        'specializations': _selectedSpecializations,
        'experience': _selectedExperience,
      };

      if (documentSnapshot.exists) {
        // If the document exists, update it with the merged data
        await FirebaseFirestore.instance
            .collection('Expert')
            .doc(widget.expertId)
            .update(data);
      } else {
        // If the document does not exist, set it with the merged data
        await FirebaseFirestore.instance
            .collection('Expert')
            .doc(widget.expertId)
            .set(data);
      }

      print('Data saved to Firestore successfully!');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExpertFlow5(
            expertId: widget.expertId,
            fullName: widget.fullName,
          ),
        ),
      );
    } catch (error) {
      print('Failed to save data to Firestore: $error');
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  void _showWelcomeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          height: MediaQuery.of(context).size.height * 0.7, // Fixed height
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'lib/assets/images/WelcomeNote.png', // Replace with your image path
                  height: 200, // Adjust the height as needed
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Ma’ayong Adlaw Expert!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Langar',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  "To be part of the HomBuddy Family, We need more Information from you.",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Please fill up and upload the necessary information as you follow the steps",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF003B5F),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 50.0),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context) {
    if (_selectedService == null ||
        _selectedSpecializations.isEmpty ||
        _selectedExperience == null) {
      _showWarningDialog(context);
    } else {
      _saveDataToFirestore(); // Save data to Firestore
    }
  }

  void _showWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Incomplete Information"),
          content: const Text(
              "Please fill up the Service, at least one specialization and sub service, and the Experience."),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  const Text(
                    "Ma'ayong Adlaw",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.fullName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Thank you for joining us! Let us get to know you by filling up the information below",
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "1. Please choose which service you are able to provide.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ServiceDropdown(
                    onChanged: (String? value) {
                      setState(() {
                        _selectedService = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "2. Please choose which specialized service you can provide.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 11),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CheckBoxListItem(
                          text: "Air-Conditioning Services",
                          subItems: const [
                            "Power Jet AC Service (Split)",
                            "AC repair (split/window)",
                            "Installing"
                          ],
                          onChecked: (isChecked) {
                            setState(() {
                              if (isChecked) {
                                _selectedSpecializations
                                    .add("Air-Conditioning Services");
                              } else {
                                _selectedSpecializations
                                    .remove("Air-Conditioning Services");
                              }
                            });
                          },
                        ),
                        CheckBoxListItem(
                          text: "Gas-Rangehood Services",
                          subItems: const [
                            "Will be implementing soon",
                          ],
                          onChecked: (isChecked) {
                            setState(() {
                              if (isChecked) {
                                _selectedSpecializations
                                    .add("Gas-Rangehood Services");
                              } else {
                                _selectedSpecializations
                                    .remove("Gas-Rangehood Services");
                              }
                            });
                          },
                        ),
                        CheckBoxListItem(
                          text: "Water Heater Services",
                          subItems: const [
                            "Will be implementing soon",
                          ],
                          onChecked: (isChecked) {
                            setState(() {
                              if (isChecked) {
                                _selectedSpecializations
                                    .add("Water Heater Services");
                              } else {
                                _selectedSpecializations
                                    .remove("Water Heater Services");
                              }
                            });
                          },
                        ),
                        CheckBoxListItem(
                          text: "Plumbing Services",
                          subItems: const [
                            "Will be implementing soon",
                          ],
                          onChecked: (isChecked) {
                            setState(() {
                              if (isChecked) {
                                _selectedSpecializations
                                    .add("Plumbing Services");
                              } else {
                                _selectedSpecializations
                                    .remove("Plumbing Services");
                              }
                            });
                          },
                        ),
                        CheckBoxListItem(
                          text: "Electrical Services",
                          subItems: const [
                            "Will be implementing soon",
                          ],
                          onChecked: (isChecked) {
                            setState(() {
                              if (isChecked) {
                                _selectedSpecializations
                                    .add("Electrical Services");
                              } else {
                                _selectedSpecializations
                                    .remove("Electrical Services");
                              }
                            });
                          },
                        ),
                        CheckBoxListItem(
                          text: "Carpentry Services",
                          subItems: const [
                            "Will be implementing soon",
                          ],
                          onChecked: (isChecked) {
                            setState(() {
                              if (isChecked) {
                                _selectedSpecializations
                                    .add("Carpentry Services");
                              } else {
                                _selectedSpecializations
                                    .remove("Carpentry Services");
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "3. How long have you been working in the industry?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: DropdownButton<String>(
                          hint: const Text('Choose Experience'),
                          value: _selectedExperience,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedExperience = value;
                            });
                          },
                          items: <String>[
                            '6 months',
                            '6 months - 1 year',
                            '2 - 4 years',
                            '5 years up'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _showBottomSheet(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF003B5F),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 15),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading) // Display loading indicator if _isLoading is true
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          Positioned(
            top: 15,
            right: 15,
            child: Image.asset(
              'lib/assets/images/homblue.png', // Replace 'assets/logo.png' with your logo path
              height: 80,
              width: 80,
            ),
          ),
        ],
      ),
    );
  }
}

class CheckBoxListItem extends StatefulWidget {
  final String text;
  final Function(bool) onChecked;
  final List<String> subItems;

  const CheckBoxListItem({
    super.key,
    required this.text,
    required this.onChecked,
    required this.subItems,
  });

  @override
  _CheckBoxListItemState createState() => _CheckBoxListItemState();
}

class _CheckBoxListItemState extends State<CheckBoxListItem> {
  bool _isChecked = false;
  bool _showSubItems = false;
  final List<bool> _subItemsChecked = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Checkbox(
                value: _isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked = value ?? false;
                    _showSubItems = _isChecked;
                  });
                  widget.onChecked(value ?? false);
                },
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(widget.text),
            ),
          ],
        ),
        if (_showSubItems)
          ...widget.subItems.map((subItem) {
            final index = widget.subItems.indexOf(subItem);
            if (_subItemsChecked.length <= index) {
              _subItemsChecked.add(false);
            }

            return CheckboxListTile(
              value: _subItemsChecked[index],
              onChanged: (value) {
                setState(() {
                  _subItemsChecked[index] = value ?? false;
                });
              },
              title: Text(subItem),
            );
          }),
      ],
    );
  }
}

class ServiceDropdown extends StatefulWidget {
  final Function(String?) onChanged;

  const ServiceDropdown({super.key, required this.onChanged});

  @override
  _ServiceDropdownState createState() => _ServiceDropdownState();
}

class _ServiceDropdownState extends State<ServiceDropdown> {
  String? selectedService;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          height: 50,
          width: 250,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
          ),
          child: DropdownButton<String>(
            hint: const Text('Choose Service'),
            value: selectedService,
            onChanged: (String? value) {
              setState(() {
                selectedService = value;
              });
              widget.onChanged(value);
            },
            items: <String>['Repair and Maintenance']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
