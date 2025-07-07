import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hombuddy/pages/FlowsBooking/BookingFlow3.dart';
import 'package:hombuddy/pages/FlowsBooking/CartModel.dart';
import 'package:hombuddy/pages/FlowsUser/UserModel.dart';
import 'package:intl/intl.dart';

class ServiceDetailsScreen2 extends StatefulWidget {
  final UserModel user;
  final String bookingId;
  final List<CartItem> cartItems;

  const ServiceDetailsScreen2({
    super.key,
    required this.user,
    required this.bookingId,
    required this.cartItems,
  });

  @override
  _ServiceDetailsScreen2State createState() => _ServiceDetailsScreen2State();
}

class _ServiceDetailsScreen2State extends State<ServiceDetailsScreen2> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  String? _selectedTimeSlot;
  String? _popupTimeSlot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Date and Time')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(const Duration(days: 30)),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: _buildTimeSlots(),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (_selectedTimeSlot != null) {
                    await _saveBookingDetails();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ServiceDetailsScreen3(
                          user: widget.user,
                          bookingId: widget.bookingId,
                          cartItems: widget.cartItems,
                        ),
                      ),
                    );
                  } else {
                    // Handle case when no time slot is selected
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please select a time slot.")));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0067A5),
                ),
                child: const Text('Confirm Booking',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTimeSlots() {
    List<String> timeSlots = [
      "8:00 AM",
      "9:00 AM",
      "10:00 AM",
      "11:00 AM",
      "12:00 PM",
      "1:00 PM",
      "2:00 PM",
      "3:00 PM",
      "4:00 PM",
      "5:00 PM",
      "6:00 PM",
      "7:00 PM",
      "8:00 PM"
    ];
    return timeSlots.map((time) => _buildTimeSlotButton(time)).toList();
  }

  Widget _buildTimeSlotButton(String time) {
    bool isSelected = _selectedTimeSlot == time;
    bool isEnabled = _isTimeSlotEnabled(time);

    return ElevatedButton(
      onPressed: isEnabled ? () => _handleTimeSlotSelection(time) : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFF0067A5) : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      ),
      child: Text(
        time,
        style: TextStyle(
            fontSize: 14.0,
            color: isSelected
                ? Colors.white
                : (isEnabled ? Colors.black : Colors.grey)),
      ),
    );
  }

  bool _isTimeSlotEnabled(String time) {
    DateTime now = DateTime.now();
    DateTime parsedTime = DateFormat("h:mm a").parse(time);
    DateTime timeSlotDateTime = DateTime(_selectedDay.year, _selectedDay.month,
        _selectedDay.day, parsedTime.hour, parsedTime.minute);
    return timeSlotDateTime.isAfter(now.add(const Duration(hours: 1)));
  }

  void _handleTimeSlotSelection(String time) {
    if (_isAfter5PM(time)) {
      _showSurchargePopup(time);
    } else {
      setState(() {
        _selectedTimeSlot = time;
      });
    }
  }

  bool _isAfter5PM(String time) {
    List<String> parts = time.split(':');
    int hour = int.parse(parts[0]);
    String amPm = parts[1].split(' ')[1];
    hour = (hour == 12 ? 0 : hour) + (amPm == 'PM' ? 12 : 0);
    return hour >= 17;
  }

  void _showSurchargePopup(String time) {
    setState(() {
      _popupTimeSlot = time;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 255, 250, 250),
          content: SizedBox(
            width: 500,
            height: 300,
            child: Image.asset(
              'lib/assets/images/OHNO.png',
              fit: BoxFit.fill,
            ),
          ),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _applySurcharge();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0067A5),
                ),
                child: const Text('Continue',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _applySurcharge() {
    setState(() {
      _selectedTimeSlot = _popupTimeSlot;
    });
  }

  Future<void> _saveBookingDetails() async {
    await FirebaseFirestore.instance
        .collection('bookings')
        .doc(widget.bookingId)
        .update({
      'dateBooked': _selectedDay,
      'timeSlot': _selectedTimeSlot,
    });
  }
}
