import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerField extends StatefulWidget {
  final void Function(String) onDateTimeSelected;
  final String? initialValue;

  const DateTimePickerField({
    super.key,
    required this.onDateTimeSelected,
    this.initialValue,
  });

  @override
  State<DateTimePickerField> createState() => _DateTimePickerFieldState();
}

class _DateTimePickerFieldState extends State<DateTimePickerField> {
  String? selectedDateTimeStr;

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    final combined = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    final formatted = DateFormat("dd/MM/yyyy-hh:mm a").format(combined);

    setState(() {
      selectedDateTimeStr = formatted;
    });

    widget.onDateTimeSelected(formatted);
  }

  @override
  void initState() {
    super.initState();
    selectedDateTimeStr = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final displayText = selectedDateTimeStr ?? "Select Date & Time";

    return InkWell(
      onTap: _pickDateTime,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              displayText,
              style: TextStyle(
                color: selectedDateTimeStr == null ? Colors.grey : Colors.black,
                fontSize: 16,
              ),
            ),
            const Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }
}
