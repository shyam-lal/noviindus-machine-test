import 'package:flutter/material.dart';
import 'package:novindus_machine_test/presentation/appointments/model/appointment_list_model.dart';
import 'package:novindus_machine_test/presentation/appointments/repository/appointment_repository.dart';

class AppointmentViewModel extends ChangeNotifier {
  final AppointmentRepository _repository = AppointmentRepository();

  AppointmentListModel? _appointments;
  AppointmentListModel? get appointments => _appointments;

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

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
}
