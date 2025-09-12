import 'package:flutter/material.dart';
import 'package:novindus_machine_test/presentation/appointments/model/appointment_list_model.dart';
import 'package:novindus_machine_test/presentation/appointments/model/branch_list_model.dart';
import 'package:novindus_machine_test/presentation/appointments/model/create_appointment_model.dart';
import 'package:novindus_machine_test/presentation/appointments/model/treatment_list_model.dart';
import 'package:novindus_machine_test/presentation/appointments/repository/appointment_repository.dart';
import 'package:novindus_machine_test/utils/receipt_generator_util.dart';
import 'package:printing/printing.dart';

class AppointmentListViewModel extends ChangeNotifier {
  final AppointmentRepository _repository = AppointmentRepository();

  AppointmentListModel? _appointments;
  AppointmentListModel? get appointments => _appointments;

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  String _sortBy = "Date";
  String get sortBy => _sortBy;

  // Fetch appointments
  Future<void> fetchAppointments() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _appointments = await _repository.fetchAppointments();
      _error = null;
    } catch (e) {
      _error = e.toString();
    }

    _loading = false;
    notifyListeners();
  }

  // Sort functions
  void setSortBy(String value) {
    _sortBy = value;
    notifyListeners();
  }

  List<Patient> get sortedPatients {
    final patients = _appointments?.patients ?? [];
    final list = [...patients];

    switch (_sortBy) {
      case "Name":
        list.sort((a, b) => (a.name ?? "").compareTo(b.name ?? ""));
        break;
      case "Price":
        list.sort((a, b) => (a.price ?? 0).compareTo(b.price ?? 0));
        break;
      case "Date":
      default:
        list.sort((a, b) {
          DateTime? aDate;
          DateTime? bDate;

          try {
            if (a.dateNdTime != null && a.dateNdTime!.isNotEmpty) {
              aDate = DateTime.tryParse(a.dateNdTime!);
            }
            if (b.dateNdTime != null && b.dateNdTime!.isNotEmpty) {
              bDate = DateTime.tryParse(b.dateNdTime!);
            }
          } catch (_) {}

          if (aDate == null && bDate == null) return 0;
          if (aDate == null) return 1;
          if (bDate == null) return -1;
          return aDate.compareTo(bDate);
        });
        break;
    }
    return list;
  }

  void onAppointmentCreated() {
    fetchAppointments();
  }
}
