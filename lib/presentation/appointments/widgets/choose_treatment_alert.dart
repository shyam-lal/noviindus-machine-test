import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:novindus_machine_test/config/constants/app_colors.dart';
import 'package:novindus_machine_test/config/decoration/size_configs.dart';
import 'package:novindus_machine_test/presentation/appointments/model/create_appointment_model.dart';

void showTreatmentSelectionAlert(
  BuildContext context,
  List<String> treatmentNames,
  Function(TreatmentModel) callback,
) {
  // remove duplicates while preserving order
  final uniqueNames = LinkedHashSet<String>.from(treatmentNames).toList();
  String maleCount = "0";
  String femaleCount = "0";

  showDialog(
    context: context,
    builder: (BuildContext context) {
      String? selectedTreatment;

      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose Treatment',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text('Choose preferred treatment'),
                        value:
                            selectedTreatment != null &&
                                    uniqueNames.contains(selectedTreatment)
                                ? selectedTreatment
                                : null,
                        items:
                            uniqueNames.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedTreatment = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Add Patients',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PatientCounter('Male', (val) => {maleCount = val}),
                      PatientCounter('Female', (val) => {femaleCount = val}),
                    ],
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final TreatmentModel model = TreatmentModel(
                          treatment: selectedTreatment,
                          male: maleCount,
                          female: femaleCount,
                        );

                        if (selectedTreatment != null) {
                          callback(model);
                        }
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('Save'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

class PatientCounter extends StatefulWidget {
  // const PatientCounter({super.key});
  final String gender;
  final Function(String) completion;

  PatientCounter(this.gender, this.completion);

  @override
  State<PatientCounter> createState() => _PatientCounterState();
}

class _PatientCounterState extends State<PatientCounter> {
  int value = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Container(
            width: SizeConfigs.screenWidth! * 0.3,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.greyBox,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(widget.gender),
          ),
          Spacer(),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (value > 0) {
                    setState(() {
                      value--;
                      widget.completion(value.toString());
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor,
                  ),
                  child: Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: SizeConfigs.screenWidth! * 0.05,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text(value.toString()),
              SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  setState(() {
                    value++;
                    widget.completion(value.toString());
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor,
                  ),
                  child: Icon(
                    Icons.add,
                    size: SizeConfigs.screenWidth! * 0.05,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
