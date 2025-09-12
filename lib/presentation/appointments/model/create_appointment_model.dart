class CreateAppointmentModel {
  final String? name;
  final String? executive;
  final String? payment;
  final String? phone;
  final String? address;
  final String? totalAmount;
  final String? discountAmount;
  final String? advanceAmount;
  final String? balanceAmount;
  final String? dateNdTime;
  final String? id;
  final String? male;
  final String? female;
  final String? branch;
  final String? treatments;

  CreateAppointmentModel({
    this.name,
    this.executive,
    this.payment,
    this.phone,
    this.address,
    this.totalAmount,
    this.discountAmount,
    this.advanceAmount,
    this.balanceAmount,
    this.dateNdTime,
    this.id,
    this.male,
    this.female,
    this.branch,
    this.treatments,
  });

  Map<String?, dynamic> toJson() {
    return {
      "name": name,
      "excecutive": executive,
      "payment": payment,
      "phone": phone,
      "address": address,
      "total_amount": totalAmount.toString(),
      "discount_amount": discountAmount.toString(),
      "advance_amount": advanceAmount.toString(),
      "balance_amount": balanceAmount.toString(),
      "date_nd_time": dateNdTime,
      "id": id,
      "male": male,
      "female": female,
      "branch": branch,
      "treatments": treatments,
    };
  }
}
