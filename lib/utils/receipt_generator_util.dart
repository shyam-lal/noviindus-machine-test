import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:novindus_machine_test/presentation/appointments/model/create_appointment_model.dart';

class ReceiptGenerator {
  static Future<Uint8List> generate(
    CreateAppointmentModel model,
    List<TreatmentModel> treatmentList,
  ) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  "Amritha Ayurveda",
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                "Patient Details",
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text("Name: ${model.name}"),
              pw.Text("Address: ${model.address}"),
              pw.Text("WhatsApp: ${model.phone}"),
              pw.SizedBox(height: 10),
              pw.Text("Treatment Date: ${model.dateNdTime}"),
              pw.SizedBox(height: 20),

              pw.Table.fromTextArray(
                headers: ["Treatment", "Male", "Female", "Price", "Total"],
                data:
                    treatmentList.map((t) {
                      return [
                        t.treatment ?? "-",
                        t.male ?? "0",
                        t.female ?? "0",
                        "₹230",
                        "₹${(int.parse(t.male ?? "0") + int.parse(t.female ?? "0")) * 230}",
                      ];
                    }).toList(),
              ),

              pw.SizedBox(height: 20),
              pw.Text("Advance: ₹${model.advanceAmount}"),
              pw.Text("Balance: ₹${model.balanceAmount}"),
              pw.Text("Discount: ₹${model.discountAmount}"),
              pw.Text("Total: ₹${model.totalAmount}"),

              pw.SizedBox(height: 30),
              pw.Text(
                "Thank you for choosing us.\nYour well-being is our commitment.",
                style: pw.TextStyle(fontSize: 12),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
