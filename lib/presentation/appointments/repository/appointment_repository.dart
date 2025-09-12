import 'package:novindus_machine_test/config/constants/url_constants.dart';
import 'package:novindus_machine_test/config/webservices/api_client.dart';
import 'package:novindus_machine_test/config/webservices/api_request.dart';
import 'package:novindus_machine_test/presentation/appointments/model/appointment_list_model.dart';

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
}
