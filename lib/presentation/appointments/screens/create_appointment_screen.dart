import 'package:flutter/material.dart';
import 'package:novindus_machine_test/config/constants/app_colors.dart';
import 'package:novindus_machine_test/presentation/appointments/model/create_appointment_model.dart';
import 'package:novindus_machine_test/presentation/appointments/viewmodel/appointment_list_vm.dart';
import 'package:novindus_machine_test/presentation/appointments/viewmodel/create_appointment_vm.dart';
import 'package:novindus_machine_test/presentation/appointments/viewmodel/master_data_vm.dart';
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

  List<TreatmentModel> treatmentList = [];

  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final addressController = TextEditingController();
  final totalController = TextEditingController();
  final discountController = TextEditingController();
  final advanceController = TextEditingController();
  final balanceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mdViewModel = context.read<MasterDataViewModel>();
    final createViewModel = context.read<CreateAppointmentViewModel>();
    final branchNames =
        mdViewModel.branches?.branches
            ?.map((e) => e.name)
            .whereType<String>()
            .toList() ??
        <String>[];

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
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
                hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
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
                hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
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
                hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
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
            }, branchNames),
            SizedBox(height: 16),
            Text('Treatments'),
            SizedBox(height: 8),

            // Treatment list items
            ...treatmentList.asMap().entries.map((entry) {
              final index = entry.key;
              final treatment = entry.value;

              return _buildTreatmentCard(index, treatment);
            }).toList(),

            SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                showTreatmentSelectionAlert(
                  context,
                  mdViewModel.treatments?.treatments ?? [],
                  (treatment) => {
                    setState(() {
                      treatmentList.add(treatment);
                    }),
                  },
                );
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
                    male: treatmentList
                        .map((e) => e.male ?? "")
                        .where((e) => e.isNotEmpty)
                        .join(","),
                    female: treatmentList
                        .map((e) => e.female ?? "")
                        .where((e) => e.isNotEmpty)
                        .join(","),
                    branch: "166",
                    treatments: treatmentList
                        .map((e) => e.treatmentId ?? "")
                        .where((e) => e.isNotEmpty)
                        .join(","),
                  );

                  // final viewModel = context.read<AppointmentViewModel>();
                  final success = await createViewModel.createAppointment(
                    appointment,
                  );

                  if (success) {
                    final _viewModel = context.read<AppointmentListViewModel>();
                    _viewModel.onAppointmentCreated();
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
                          createViewModel.error ??
                              "Failed to create appointment",
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
          hint: Text(
            hintText,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
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

  Widget _buildTreatmentCard(int index, TreatmentModel model) {
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
                    '${index + 1} ${model.treatment}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      _buildCountButton('Male', model.male ?? "0"),
                      SizedBox(width: 8),
                      _buildCountButton('Female', model.female ?? "0"),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Icon(Icons.cancel_outlined, color: Colors.red),
                SizedBox(width: 50),
                Icon(Icons.edit, color: Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCountButton(String label, String count) {
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
          Text(count, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
