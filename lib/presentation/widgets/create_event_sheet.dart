import 'package:event_app/presentation/widgets/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../data/model/event.dart';
import 'category_item.dart';

class CreateEventSheet extends StatefulWidget {
  final ValueChanged<Event> onEventCreated;
  const CreateEventSheet({super.key,required this.onEventCreated});

  @override
  State<CreateEventSheet> createState() => _CreateEventSheetState();
}

class _CreateEventSheetState extends State<CreateEventSheet> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  bool remindMe = false;
  String selectedCategory = "";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked; // Update the selected date
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss keyboard on tap
        FocusScope.of(context).unfocus();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Center(child: Text(
              'Add New Event',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'SFUIText',
                  fontSize: 20,
                  fontWeight: FontWeight.w600
              )),
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300,width: 1.0)
            ),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Enter name*',
                hintStyle: TextStyle(
                    fontFamily: 'SFUIText',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color:Colors.grey[400]
                ),
                border: InputBorder.none,
              ),
            ),
          ),


          const SizedBox(height: 20.0),
          Container(
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300,width: 1.0)
            ),
            child: TextField(
              controller: descController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Type the note here...',
                hintStyle: TextStyle(
                    fontFamily: 'SFUIText',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color:Colors.grey[400]
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 20,),
          GestureDetector(
            onTap: () { _selectDate(context); },
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
                  Text( selectedDate != null
                      ? '${selectedDate!.toLocal()}'.split(' ')[0]
                      : 'Date', style: TextStyle(
                      fontFamily: 'SFUIText',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color:Colors.grey[400]
                  )),
                  SvgPicture.asset(
                    'assets/images/event.svg', // Replace with your SVG file name
                    width: 24, // Set width
                    height: 24,
                    colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),// Set height
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
              children: [
                Expanded(
                  child: TimePicker(
                      onTimeSelected: (selected) => {
                        setState(() {
                          selectedStartTime = selected;
                        })
                      },
                      text:'Start Time'
                  ),
                ),
                const SizedBox(width: 16.0), // Space between the text fields
                Expanded(
                  child:TimePicker(
                      onTimeSelected: (selected) => {
                        setState(() {
                          selectedEndTime = selected;
                        })
                      },
                      text:'End Time'
                  ),
                ),
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Reminds me',style: TextStyle(
                    fontFamily: 'SFUIText',
                    fontSize: 14,
                    fontWeight: FontWeight.w400
                )),
                Switch(
                    value: remindMe,
                    onChanged: (value) => {
                      setState(() {
                        remindMe = value;
                      })
                    })
              ]
          ),
          const Text(
              'Select Category',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'SFUIText',
                  fontSize: 20,
                  fontWeight: FontWeight.w600
              )),
          SizedBox(height: 10),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = 'brainstorm';
                    });
                  },
                  child: CategoryItem(
                    color: const Color(0xFF735BF2),
                    name:'Brainstorm',
                    selected: selectedCategory.toLowerCase() == 'brainstorm'
                  )
                ),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = 'design';
                      });
                    },
                  child: CategoryItem(
                      color: Color(0xFF00B383),
                      name:'Design',
                      selected: selectedCategory.toLowerCase() == 'design'
                  )
                ),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = 'workout';
                      });
                    },
                  child: CategoryItem(
                      color: Color(0xFF0095FF),
                      name:'workout',
                      selected: selectedCategory.toLowerCase() == 'workout'
                  )
                )
              ],
            ),
          ),
          const Text('+ Add new',
              style: TextStyle(
                  fontFamily: 'SFUIText',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF735BF2)
              )),
          const SizedBox(height: 20.0),
           GestureDetector(
            onTap: () {
              final String name = nameController.text;
              final String notes = descController.text;
              if (
                  name.isNotEmpty &&
                  notes.isNotEmpty &&
                  selectedDate != null &&
                  selectedStartTime != null &&
                  selectedEndTime != null &&
                  selectedCategory.isNotEmpty
              ) {

                String date = DateFormat('yyyy-MM-dd').format(selectedDate!);

                Event event = Event(name,notes,date,selectedStartTime!,selectedEndTime!,remindMe,selectedCategory);
                widget.onEventCreated(event);

                nameController.clear();
                descController.clear();
                selectedStartTime = null;
                selectedEndTime = null;
                remindMe = false;
                selectedCategory = '';
              }
            },
            child: Container(
              width: 351,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(0xFF735BF2),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: const Text(
                  'Create Event',
                  style: TextStyle(
                      color: Colors.white
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
