import 'package:flutter/material.dart';
import 'package:novindus_machine_test/presentation/appointments/model/appointment_list_model.dart';
import 'package:novindus_machine_test/presentation/appointments/model/branch_list_model.dart';
import 'package:novindus_machine_test/presentation/appointments/model/create_appointment_model.dart';
import 'package:novindus_machine_test/presentation/appointments/model/treatment_list_model.dart';
import 'package:novindus_machine_test/presentation/appointments/repository/appointment_repository.dart';
import 'package:novindus_machine_test/utils/receipt_generator_util.dart';
import 'package:printing/printing.dart';

class AppointmentViewModel extends ChangeNotifier {
  final AppointmentRepository _repository = AppointmentRepository();

  AppointmentListModel? _appointments;
  AppointmentListModel? get appointments => _appointments;

  TreatmentListModel? _treatments;
  TreatmentListModel? get treatments => _treatments;

  BranchListModel? _branches;
  BranchListModel? get branches => _branches;

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
    } catch (e) {
      _error = e.toString();
    }

    _loading = false;
    notifyListeners();
  }

  // Fetch treatmments
  Future<bool> fetchTreatments() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _treatments = await _repository.fetchTreatments();
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // Fetch branches
  Future<bool> fetchBranches() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _branches = await _repository.fetchBranches();
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // Create appointment
  Future<bool> createAppointment(CreateAppointmentModel appointment) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final success = await _repository.createAppointment(appointment);
      _loading = false;
      notifyListeners();
      return success;
    } catch (e) {
      _loading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
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

  // Receipt printing
  Future<void> onAppointmentCreated(
    CreateAppointmentModel model,
    List<TreatmentModel> treatmentList,
  ) async {
    final pdfData = await ReceiptGenerator.generate(model, treatmentList);

    await Printing.layoutPdf(onLayout: (_) async => pdfData);
    await Printing.sharePdf(bytes: pdfData, filename: "receipt.pdf");
  }
}
