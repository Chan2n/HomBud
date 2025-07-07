import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransferAmountScreen extends StatefulWidget {
  final String email;

  const TransferAmountScreen({super.key, required this.email});

  @override
  _TransferAmountScreenState createState() => _TransferAmountScreenState();
}

class _TransferAmountScreenState extends State<TransferAmountScreen> {
  final TextEditingController _amountController = TextEditingController();

  void _confirmTransfer() async {
    final amount = _amountController.text;
    if (amount.isNotEmpty) {
      double transferAmount = double.tryParse(amount) ?? 0.0;
      if (transferAmount > 0) {
        try {
          var snapshot = await FirebaseFirestore.instance
              .collection('Expert')
              .where('Email', isEqualTo: widget.email)
              .get();

          if (snapshot.docs.isNotEmpty) {
            var doc = snapshot.docs.first;
            DocumentReference expertDoc = doc.reference;

            await FirebaseFirestore.instance
                .runTransaction((transaction) async {
              DocumentSnapshot snapshot = await transaction.get(expertDoc);

              if (!snapshot.exists) {
                throw Exception("Expert does not exist!");
              }

              Map<String, dynamic> data =
                  snapshot.data() as Map<String, dynamic>;
              double currentCredits = data.containsKey('Credit Wallet')
                  ? data['Credit Wallet']
                  : 0.0;
              double newCredits = currentCredits + transferAmount;

              transaction.update(expertDoc, {'Credit Wallet': newCredits});
            });

            // Pop the screen after saving
            Navigator.pop(context);
          } else {
            throw Exception("Expert does not exist!");
          }
        } catch (e) {
          // Handle errors
          print(e);
          // Show a snackbar or dialog with an error message
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer Amount'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text(
                'Amount to Transfer',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '₱ Enter Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: _confirmTransfer,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF003B5F),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
