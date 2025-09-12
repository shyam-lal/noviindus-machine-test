import 'package:novindus_machine_test/config/constants/url_constants.dart';
import 'package:novindus_machine_test/config/webservices/api_client.dart';
import 'package:novindus_machine_test/config/webservices/api_request.dart';
import 'package:novindus_machine_test/presentation/appointments/model/appointment_list_model.dart';
import 'package:novindus_machine_test/presentation/appointments/model/branch_list_model.dart';
import 'package:novindus_machine_test/presentation/appointments/model/create_appointment_model.dart';
import 'package:novindus_machine_test/presentation/appointments/model/treatment_list_model.dart';

class AppointmentRepository {
  Future<AppointmentListModel> fetchAppointments() async {
    final request = ApiRequest(
      url: Uri.parse(BaseUrl.v1 + EndPoint.patientList),
    );

    final response = await ApiClient.getData(
      request,
      (dynamic json) => AppointmentListModel.fromJson(json),
    );

    if (response?.data != null) {
      return response!.data!;
    } else {
      throw Exception(response?.error ?? "Failed to load appointments");
    }
  }

  Future<TreatmentListModel> fetchTreatments() async {
    final request = ApiRequest(
      url: Uri.parse(BaseUrl.v1 + EndPoint.treatments),
    );

    final response = await ApiClient.getData(
      request,
      (dynamic json) => TreatmentListModel.fromJson(json),
    );

    if (response?.data != null) {
      return response!.data!;
    } else {
      throw Exception(response?.error ?? "Failed to load treatments");
    }
  }

  Future<BranchListModel> fetchBranches() async {
    final request = ApiRequest(url: Uri.parse(BaseUrl.v1 + EndPoint.branches));

    final response = await ApiClient.getData(
      request,
      (dynamic json) => BranchListModel.fromJson(json),
    );

    if (response?.data != null) {
      return response!.data!;
    } else {
      throw Exception(response?.error ?? "Failed to load branches");
    }
  }

  Future<bool> createAppointment(CreateAppointmentModel appointment) async {
    final request = ApiRequest(
      url: Uri.parse(BaseUrl.v1 + EndPoint.registerPatient),
      body: appointment.toJson(),
    );

    final response = await ApiClient.postData<Map<String, dynamic>>(
      request: request,
      fromJson: (json) => json as Map<String, dynamic>,
      needsHeader: true,
      formUrlEncoded: true,
    );

    if (response?.data != null && response!.data!["status"] == true) {
      return true;
    } else {
      throw Exception(
        response?.data?["message"] ?? "Failed to create appointment",
      );
    }
  }
}
