import 'package:flutter/material.dart';
import 'package:novindus_machine_test/config/constants/app_colors.dart';
import 'package:novindus_machine_test/config/decoration/size_configs.dart';

void showTreatmentSelectionAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: Text('Choose preferred treatment'),
                    items:
                        ['Haircut', 'Hair Spa', 'Facial'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (String? newValue) {},
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
                  _buildPatientCounter('Male'),
                  _buildPatientCounter('Female'),
                ],
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1E8449),
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
}

Widget _buildPatientCounter(String gender) {
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
          child: Text(gender),
        ),
        Spacer(),
        Row(
          children: [
            Container(
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
            SizedBox(width: 8),
            Text('0'),
            SizedBox(width: 8),
            Container(
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
          ],
        ),
      ],
    ),
  );
}
