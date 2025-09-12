import 'package:flutter/material.dart';
import 'package:novindus_machine_test/presentation/appointments/model/create_appointment_model.dart';
import 'package:novindus_machine_test/presentation/appointments/repository/appointment_repository.dart';
import 'package:novindus_machine_test/utils/receipt_generator_util.dart';
import 'package:printing/printing.dart';

class CreateAppointmentViewModel extends ChangeNotifier {
  final AppointmentRepository _repository = AppointmentRepository();

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  bool _isCreating = false;
  bool get isCreating => _isCreating;

  // Create appointment
  Future<bool> createAppointment(CreateAppointmentModel appointment) async {
    _isCreating = true;
    _error = null;
    notifyListeners();

    try {
      final success = await _repository.createAppointment(appointment);
      return success;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isCreating = false;
      notifyListeners();
    }
  }

  // Receipt printing
  Future<void> generateReceipt(
    CreateAppointmentModel model,
    List<TreatmentModel> treatmentList,
  ) async {
    try {
      final pdfData = await ReceiptGenerator.generate(model, treatmentList);
      await Printing.layoutPdf(onLayout: (_) async => pdfData);
      await Printing.sharePdf(bytes: pdfData, filename: "receipt.pdf");
    } catch (e) {
      _error = "Failed to generate receipt: $e";
      notifyListeners();
    }
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
