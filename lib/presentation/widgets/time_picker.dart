import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TimePicker extends StatefulWidget {
  final ValueChanged<TimeOfDay> onTimeSelected;
  final String text;

  TimePicker({
    required this.onTimeSelected,
    required this.text
  });

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: selectedTime ?? TimeOfDay.now(),
        );
        if (picked != null && picked != selectedTime) {
          setState(() {
            selectedTime = picked; // Update the selected time
          });
          widget.onTimeSelected(selectedTime ?? TimeOfDay.now());
        }
      },
      child: Container(
        height: 62,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300,width: 1.0)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                selectedTime != null ?
                ' ${selectedTime!.format(context)}'
                    : widget.text,
                style: TextStyle(
                    fontFamily: 'SFUIText',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color:Colors.grey[400]
                )),
            SvgPicture.asset(
              'assets/images/time.svg', // Replace with your SVG file name
              width: 24, // Set width
              height: 24, // Set height
            ),
          ],
        ),
      ),
    );
  }
}