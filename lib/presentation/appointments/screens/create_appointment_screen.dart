import 'package:flutter/material.dart';
import 'package:novindus_machine_test/config/constants/app_colors.dart';
import 'package:novindus_machine_test/presentation/appointments/model/create_appointment_model.dart';
import 'package:novindus_machine_test/presentation/appointments/viewmodel/appointment_viewmodel.dart';
import 'package:novindus_machine_test/presentation/appointments/widgets/choose_treatment_alert.dart';
import 'package:novindus_machine_test/presentation/appointments/widgets/date_time_picker_field.dart';
import 'package:provider/provider.dart';

class CreateAppointmentScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<CreateAppointmentScreen> {
  String? _selectedLocation;
  String? _selectedBranch;
  String? _paymentOption = 'Cash';
  String? _selectedHour;
  String? _selectedMinute;
  String? pickedDateTime;

  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final addressController = TextEditingController();
  final totalController = TextEditingController();
  final discountController = TextEditingController();
  final advanceController = TextEditingController();
  final balanceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Register',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Name'),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Enter your full name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16),
            Text('Whatsapp Number'),
            TextField(
              controller: numberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter your Whatsapp number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16),
            Text('Address'),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                hintText: 'Enter your full address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16),
            Text('Location'),
            _buildDropdownField('Choose your location', _selectedLocation, (
              String? newValue,
            ) {
              setState(() {
                _selectedLocation = newValue;
              });
            }, ['Location A', 'Location B']),
            SizedBox(height: 16),
            Text('Branch'),
            _buildDropdownField('Select the branch', _selectedBranch, (
              String? newValue,
            ) {
              setState(() {
                _selectedBranch = newValue;
              });
            }, ['Branch 1', 'Branch 2']),
            SizedBox(height: 16),
            Text('Treatments'),
            SizedBox(height: 8),
            _buildTreatmentCard(),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                showTreatmentSelectionAlert(context);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    '+ Add Treatments',
                    style: TextStyle(
                      color: Colors.green[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text('Total Amount'),
            TextField(
              controller: totalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16),
            Text('Discount Amount'),
            TextField(
              controller: discountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16),
            Text('Payment Option'),
            Row(
              children: [
                _buildRadioOption('Cash'),
                _buildRadioOption('Card'),
                _buildRadioOption('UPI'),
              ],
            ),
            SizedBox(height: 16),
            Text('Advance Amount'),
            TextField(
              controller: advanceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16),
            Text('Balance Amount'),
            TextField(
              controller: balanceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16),
            Text('Treatment Date'),
            DateTimePickerField(
              onDateTimeSelected: (value) {
                setState(() {
                  pickedDateTime = value; // you get string here
                });
              },
            ),
            SizedBox(height: 16),
            Text('Treatment Time'),
            Row(
              children: [
                Expanded(
                  child: _buildDropdownField('Hour', _selectedHour, (
                    String? newValue,
                  ) {
                    setState(() {
                      _selectedHour = newValue;
                    });
                  }, ['01', '02', '03']),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: _buildDropdownField('Minutes', _selectedMinute, (
                    String? newValue,
                  ) {
                    setState(() {
                      _selectedMinute = newValue;
                    });
                  }, ['00', '15', '30', '45']),
                ),
              ],
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  final appointment = CreateAppointmentModel(
                    name: nameController.text.toString(),
                    executive: "Executive Name",
                    payment: "10",
                    phone: numberController.text.toString(),
                    address: addressController.text.toString(),
                    totalAmount: totalController.text.toString(),
                    discountAmount: discountController.text.toString(),
                    advanceAmount: advanceController.text.toString(),
                    balanceAmount: balanceController.text.toString(),
                    dateNdTime: pickedDateTime,
                    id: "",
                    male: "2,3,4",
                    female: "2,3,4",
                    branch: "166",
                    treatments: "100,90,86",
                  );

                  final viewModel = context.read<AppointmentViewModel>();
                  final success = await viewModel.createAppointment(
                    appointment,
                  );

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Appointment created successfully"),
                      ),
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          viewModel.error ?? "Failed to create appointment",
                        ),
                      ),
                    );
                  }
                },
                child: Text('Save'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField(
    String hintText,
    String? value,
    Function(String?) onChanged,
    List<String> items,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(hintText),
          value: value,
          icon: Icon(Icons.arrow_drop_down),
          onChanged: onChanged,
          items:
              items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildRadioOption(String title) {
    return Expanded(
      child: RadioListTile<String>(
        title: Text(title, style: TextStyle(fontSize: 12)),
        value: title,
        groupValue: _paymentOption,
        onChanged: (String? value) {
          setState(() {
            _paymentOption = value;
          });
        },
      ),
    );
  }

  Widget _buildTreatmentCard() {
    return Card(
      color: Colors.green[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1. Couple Combo package (Haircut, Hair Spa)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      _buildCountButton('Male', 2),
                      SizedBox(width: 8),
                      _buildCountButton('Female', 2),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.cancel_outlined, color: Colors.red),
            SizedBox(width: 8),
            Icon(Icons.edit, color: Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildCountButton(String label, int count) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Text(label),
          SizedBox(width: 4),
          Text(count.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
