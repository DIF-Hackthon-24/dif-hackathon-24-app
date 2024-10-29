import 'package:flutter/material.dart';

class PermissionRequestWidget extends StatelessWidget {
  final String recipient;
  final Function()? onGranted;
   const PermissionRequestWidget({super.key, required this.recipient, this.onGranted});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 350,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          // const SizedBox(height: 20.0),
          RichText(
            text:  TextSpan(
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: recipient,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18,),
                ),
                const TextSpan(text: ' is requesting the following permissions'),
              ],
            ),
          ),
          const Spacer(),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Read',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,),
                ),
                TextSpan(text: ' access on '),
                TextSpan(
                  text: 'traveler profile',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                TextSpan(text: ' preferences'),
              ],
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => onGranted!(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Background color
                  minimumSize: const Size(150, 40),
                ),
                child: const Text('Grant'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle deny action
                  print('Deny permission');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Background color
                  minimumSize: const Size(150, 40),
                ),
                child: const Text('Deny'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
