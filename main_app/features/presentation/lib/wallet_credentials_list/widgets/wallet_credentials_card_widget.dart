import 'dart:core';

import 'package:domain/entity/wallet_credentials_list/wallet_credentials_list_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class CredentialCard extends StatelessWidget {
  final WalletCredentialListEntity credentialCard;
  final Function(String?)? onShared;

  CredentialCard({
    Key? key,
    required this.credentialCard,
    required this.onShared,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? getData = credentialCard.document;

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blueAccent, // Set the border color to blue
          width: 2, // Adjust the width as desired
        ),
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Color(0xFFF8F8F8), // Very light off-white color
            Color(0xFFFCFCFC), // Slightly darker off-white for a soft gradient
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12, // Soft shadow for a subtle 3D effect
            blurRadius: 6,
            offset: Offset(2, 4), // Position the shadow slightly below and to the right
          ),
        ],
      ),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Credential Details',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            _buildCredentialList(getData?['vc']['credentialSubject']),
            const SizedBox(height: 10),
            const Text('VC Type',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('${getData!['vc']['type'].map((item) => _splitCamelCase(item)).join(', ')}',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.normal)),
            const SizedBox(height: 10),
            const Text('Issuer',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            // const SizedBox(height: 5),
            _buildIssuerList(getData['iss']),
            const SizedBox(height: 10),
            const Text('Date Added',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('${_formatDate(credentialCard.addedOn)}',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.normal)),            

            if (credentialCard.deletedOn != null) ...[
              const SizedBox(height: 5),
              const Text(
                'Deleted Date',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '${credentialCard.deletedOn}',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.normal),
              ),
            ],

            if (getData['vc']['credentialSubject']['achievement'] == null) ...[
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () => onShared!(credentialCard.id),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Background color
                    minimumSize: const Size(150, 40), // Width and height
                  ),
                  child: const Text(
                    'Share',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold// Text color
                    ),
                  ),
                ),
              )
            ]

          ],
        ),
      ),
    );
  }

  Widget _buildIssuerList(String did) {
    String components = _processDid(did);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Issuer:  $components', style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  String _processDid(String did) {
    List<String> components = did.split(':');
    
    if (components.length > 1) {
      String lastComponent = components.last;
      
      // Map based on the starting characters of the last component
      if (lastComponent.startsWith("z6Mk")) {
        return "IDV Provider";
      } else if (lastComponent.startsWith("star")) {
        return "Starlight Hotels";
      } else {
        return lastComponent;
      }
    } else {
      return 'Invalid DID format';
    }
  }

  String _formatDate(String? dateString) {
    DateTime dateTime = DateTime.parse(dateString!);
    String formattedDate = DateFormat('dd-MMM-yyyy').format(dateTime);
    return formattedDate;
  }

  String _splitCamelCase(String text) {
    return text.replaceAllMapped(
      RegExp(r'(?<!^)(?=[A-Z])'),
      (Match match) => ' ',
    );
  }

  Widget _buildCredentialList(Map<String, dynamic> items) {
    List<Widget> itemWidgets;
    if (items['achievement'] != null) {
      itemWidgets = [
        RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 16, color: Colors.black),
            children: [
              TextSpan(
                text: 'Name : ',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: '${items['achievement']['name']}',
                style: const TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 16, color: Colors.black),
            children: [
              TextSpan(
                text: 'Description : ',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: '${items['achievement']['description']}',
                style: const TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ];
    } else {
      // Create a list of Text widgets for each key-value pair
      itemWidgets = items.entries.map((entry) {
        String displayValue;
        if (entry.key == 'ExpiresAt') {
          displayValue = _formatDate(entry.value);
        } else if (entry.key == 'TotalAmount') {
          displayValue = '\$${entry.value}';
        } else {
          displayValue = entry.value;
        }
        
        return RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 16, color: Colors.black),
            children: [
              TextSpan(
                text: '${entry.key}: ',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: '${displayValue}',
                style: const TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        );
      }).toList();
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: itemWidgets,
    );
  }
}
