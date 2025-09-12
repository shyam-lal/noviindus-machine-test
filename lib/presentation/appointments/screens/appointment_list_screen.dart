import 'package:flutter/material.dart';
import 'package:novindus_machine_test/config/constants/app_routes.dart';
import 'package:novindus_machine_test/config/decoration/size_configs.dart';
import 'package:novindus_machine_test/presentation/appointments/model/appointment_list_model.dart';
import 'package:novindus_machine_test/presentation/appointments/viewmodel/appointment_viewmodel.dart';
import 'package:provider/provider.dart';

class AppointmentListScreen extends StatefulWidget {
  const AppointmentListScreen({super.key});

  @override
  State<AppointmentListScreen> createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen> {
  @override
  void initState() {
    super.initState();

    // Trigger fetch after widget is mounted
    Future.microtask(() {
      context.read<AppointmentViewModel>().fetchAppointments();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppointmentViewModel>();

    if (vm.loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (vm.error != null) {
      return Scaffold(body: Center(child: Text("Error: ${vm.error}")));
    }
    final viewModel = context.watch<AppointmentViewModel>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Stack(
          children: [
            // Body
            Column(
              children: [
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for treatments',
                          hintStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          prefixIcon: const Icon(Icons.search, size: 20),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D5325),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Search',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Sort by :'),
                    // const SizedBox(width: 8),
                    Spacer(),
                    SizedBox(
                      width: SizeConfigs.screenWidth! * 0.3,
                      // height: SizeConfigs.screenHeight! * 0.1,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            // vertical: 8,
                          ),
                        ),
                        value: viewModel.sortBy,
                        items:
                            ['Date', 'Name', 'Price']
                                .map(
                                  (label) => DropdownMenuItem(
                                    value: label,
                                    child: Text(
                                      label,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            viewModel.setSortBy(value);
                          }
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => viewModel.fetchAppointments(),
                    child: Builder(
                      builder: (context) {
                        if (viewModel.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (viewModel.error != null) {
                          return Center(
                            child: Text("Error: ${viewModel.error}"),
                          );
                        }

                        final patients = viewModel.sortedPatients;
                        if (patients == null || patients.isEmpty) {
                          return const Center(
                            child: Text("No appointments found"),
                          );
                        }

                        return ListView.builder(
                          // padding: const EdgeInsets.all(16),
                          itemCount: patients.length,
                          itemBuilder: (context, index) {
                            final patient = patients[index];
                            return BookingCard(
                              patient: patient,
                              index: index + 1,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),

            // Register button
            Positioned(
              left: 0,
              right: 0,
              bottom: 50,
              child: ElevatedButton(
                onPressed: () async {
                  final treatmentsOk = await viewModel.fetchTreatments();
                  if (treatmentsOk) {
                    final branchesOk = await viewModel.fetchBranches();
                    if (branchesOk) {
                      Navigator.pushNamed(context, AppRoutes.createAppointment);
                    }
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D5325),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final Patient patient;
  final int index;

  const BookingCard({super.key, required this.patient, required this.index});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "$index. ${patient.name}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "${patient.patientdetailsSet?.first.treatmentName}",
              style: TextStyle(color: Colors.green),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  '${patient.dateNdTime}',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.people, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                const Text('Jithesh', style: TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'View Booking details',
                  style: TextStyle(color: Color(0xFF0D5325)),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: const Color(0xFF0D5325).withOpacity(0.5),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
