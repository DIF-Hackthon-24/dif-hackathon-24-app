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
                fontSize: 22.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: recipient,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: ' is requesting the following permissions:'),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Center(
              child:
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Read',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ' access on '),
                      TextSpan(
                        text: 'traveler profile',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ' preferences'),
                    ],
                  ),
                )
          ),
          const Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Flexible(
                child: _buildCTAButton(
                  context,
                  icon: Icons.block,
                  title: 'Deny',
                  onTap: () {
                    // Handle Credentials List action
                    print("Denied");
                  },
                ),
              ),
              SizedBox(width: 20), // Add a gap of 10 pixels
              Flexible(
                child: _buildCTAButton(
                  context,
                  icon: Icons.check_circle_outline,
                  title: 'Grant',
                  onTap: () => onGranted!(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCTAButton(BuildContext context,
      {required IconData icon, required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: title == 'Deny' ? Colors.red : Colors.green, // Set the border color here
            width: 2.0,         // Set the border width here
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: title == 'Deny' ? Colors.red : Colors.green),
              const SizedBox(width: 8.0), // Add some space between the icon and the text
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
