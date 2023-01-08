import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sanskriti/user/components/custom_input.dart';
import 'package:sanskriti/utils/big_button.dart';

class BookingScreen extends StatefulWidget {
  final String artistId;
  final String programName;
  const BookingScreen(
      {super.key, required this.artistId, required this.programName});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final location = TextEditingController();
  final remark = TextEditingController();

  DateTime date = DateTime.now();

  void _showDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 30)))
        .then((value) {
      if (value != null) {
        date = value;
        setState(() {});
      }
    });
  }

  void _request() {
    if (location.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a location')));
      return;
    }

    FirebaseDatabase.instance.ref('requests').push().set({
      'location': location.text,
      'remark': remark.text,
      'date': date.millisecondsSinceEpoch,
      'artistId': widget.artistId,
      'programName': widget.programName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'status': 0,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Request Booking'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(widget.programName,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      )),
                ),

                // Date picker
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton.icon(
                        onPressed: () => _showDatePicker(context),
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(10)),
                        icon: const Icon(Icons.calendar_today),
                        label: const Text('Select Date'),
                      ),
                    ),
                    Text(' ${date.day}/${date.month}/${date.year}',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        )),
                  ],
                ),

                RequestInput(controller: location),
                RequestInput(
                  controller: remark,
                  isRemark: true,
                ),
                BigButton(
                    text: "Request",
                    color: const Color.fromARGB(97, 183, 147, 241),
                    callback: _request,
                    icon: Icons.send)
              ],
            ),
          ),
        ));
  }
}
