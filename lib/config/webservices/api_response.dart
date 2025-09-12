class ApiResponse<T> {
  T? data;
  dynamic error;

  ApiResponse({this.data, this.error});
}