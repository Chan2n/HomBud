import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _updatesPushNotifications = false;
  bool _updatesEmailNotifications = false;
  bool _updatesSMSNotifications = false;

  bool _dealsPushNotifications = false;
  bool _dealsEmailNotifications = false;
  bool _dealsSMSNotifications = false;

  bool _feedbackPushNotifications = false;
  bool _feedbackEmailNotifications = false;
  bool _feedbackSMSNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Updates',
                style: TextStyle(
                  fontSize: 14.0, // Adjust the size as needed
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Be the first to know our latest updates',
                style: TextStyle(
                  fontSize: 12.0, // Adjust the size as needed
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              _buildSettingsCard(
                  'Push Notifications', _updatesPushNotifications, (value) {
                setState(() {
                  _updatesPushNotifications = value;
                });
              }),
              _buildSettingsCard('Email', _updatesEmailNotifications, (value) {
                setState(() {
                  _updatesEmailNotifications = value;
                });
              }),
              _buildSettingsCard('SMS', _updatesSMSNotifications, (value) {
                setState(() {
                  _updatesSMSNotifications = value;
                });
              }),
              const SizedBox(height: 15.0),
              const Text(
                'Deals & Offers',
                style: TextStyle(
                  fontSize: 14.0, // Adjust the size as needed
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Based on your profile and marketing communications',
                style: TextStyle(
                  fontSize: 12.0, // Adjust the size as needed
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildSettingsCard('Push Notifications', _dealsPushNotifications,
                  (value) {
                setState(() {
                  _dealsPushNotifications = value;
                });
              }),
              _buildSettingsCard('Email', _dealsEmailNotifications, (value) {
                setState(() {
                  _dealsEmailNotifications = value;
                });
              }),
              _buildSettingsCard('SMS', _dealsSMSNotifications, (value) {
                setState(() {
                  _dealsSMSNotifications = value;
                });
              }),
              const SizedBox(height: 15.0),
              const Text(
                'Feedback',
                style: TextStyle(
                  fontSize: 14.0, // Adjust the size as needed
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Provide feedback to help make HomBuddy better',
                style: TextStyle(
                  fontSize: 12.0, // Adjust the size as needed
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildSettingsCard(
                  'Push Notifications', _feedbackPushNotifications, (value) {
                setState(() {
                  _feedbackPushNotifications = value;
                });
              }),
              _buildSettingsCard('Email', _feedbackEmailNotifications, (value) {
                setState(() {
                  _feedbackEmailNotifications = value;
                });
              }),
              _buildSettingsCard('SMS', _feedbackSMSNotifications, (value) {
                setState(() {
                  _feedbackSMSNotifications = value;
                });
              }),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsCard(
      String title, bool value, ValueChanged<bool> onChanged) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Transform.scale(
              scale: 0.8, // Adjust the scale factor as needed
              child: Switch(
                value: value,
                onChanged: onChanged,
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
