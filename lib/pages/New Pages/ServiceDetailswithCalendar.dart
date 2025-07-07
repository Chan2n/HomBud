import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ServiceDetailsScreen extends StatefulWidget {
  const ServiceDetailsScreen({super.key});

  @override
  _ServiceDetailsScreenState createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Details'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'lib/assets/img.png', // Adjust the logo path
              width: 50,
              height: 50,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select date and time',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TableCalendar(
              firstDay: DateTime.utc(2022, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: CalendarStyle(
                // Adjust the size of the calendar
                defaultTextStyle: const TextStyle(fontSize: 14),
                todayDecoration: BoxDecoration(
                  color: Colors.blue[200],
                  shape: BoxShape.circle,
                ),
                selectedDecoration: const BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle,
                ),
              ),
              rowHeight: 30, // Adjust the row height here
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTimeSlotButton('8:00 AM'),
                _buildTimeSlotButton('9:00 AM'),
                _buildTimeSlotButton('10:00 AM'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTimeSlotButton('11:00 AM'),
                _buildTimeSlotButton('12:00 PM'),
                _buildTimeSlotButton('1:00 PM'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTimeSlotButton('2:00 PM'),
                _buildTimeSlotButton('3:00 PM'),
                _buildTimeSlotButton('4:00 PM'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTimeSlotButton('5:00 PM'),
                _buildTimeSlotButton('6:00 PM'),
                _buildTimeSlotButton('7:00 PM'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left:17), // Add padding
              child: Row(
                children: [
                  _buildTimeSlotButton('8:00 PM'),
                ],
              ),
            ),

            // Add time slots buttons here
            const SizedBox(height: 1),
            const Divider(),
            const SizedBox(height: 1),
            const Padding(
              padding: EdgeInsets.only(left: 25.0), // Add left padding
              child: Row(
                children: [
                  Text('Location'),
                  SizedBox(width: 150),
                  Text('Address'),
                ],
              ),
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.only(left: 25.0), // Add left padding
              child: Row(
                children: [
                  Text('Date & Time'),
                  SizedBox(width: 127),
                  Text('Month | Day | Time'), // Sample cost
                ],
              ),
            ),

            const SizedBox(height: 15),
            const Divider(),
            const Padding(
              padding: EdgeInsets.only(left: 35.0), // Add left padding
              child: Row(
                children: [
                  Text('HB Voucher'),
                  SizedBox(width: 177),
                  Text('Select'), // Sample cost
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25.0), // Add left padding
              child: Row(
                children: [
                  Text('Item(s)'),
                  SizedBox(width: 220),
                  Text('0'), // Sample cost
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25.0), // Add left padding
              child: Row(
                children: [
                  Text('TOTAL COST'),
                  SizedBox(width: 153),
                  Text('PHP 0'), // Sample cost
                ],
              ),
            ),// Add HB Voucher, Item/s, Total cost details here
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Continue button functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
Widget _buildTimeSlotButton(String time) {
  return ElevatedButton(
    onPressed: () {
      // Handle button tap
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      side: const BorderSide(color: Colors.grey), // Add border
      minimumSize: const Size(80, 20), // Set button size
    ),
    child: Text(time,style: const TextStyle(color: Colors.black)),
  );
}
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My App',
      home: ServiceDetailsScreen(),
    );
  }
}
