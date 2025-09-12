import 'package:flutter/material.dart';
import 'package:novindus_machine_test/presentation/appointments/model/branch_list_model.dart';
import 'package:novindus_machine_test/presentation/appointments/model/treatment_list_model.dart';
import 'package:novindus_machine_test/presentation/appointments/repository/appointment_repository.dart';

class MasterDataViewModel extends ChangeNotifier {
  final AppointmentRepository _repository = AppointmentRepository();

  TreatmentListModel? _treatments;
  TreatmentListModel? get treatments => _treatments;

  BranchListModel? _branches;
  BranchListModel? get branches => _branches;

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  // Fetch both treatments and branches
  Future<bool> fetchMasterData() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final treatmentsFuture = _repository.fetchTreatments();
      final branchesFuture = _repository.fetchBranches();

      final results = await Future.wait([treatmentsFuture, branchesFuture]);

      _treatments = results[0] as TreatmentListModel;
      _branches = results[1] as BranchListModel;

      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // Individual fetch methods
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
}
