import 'dart:core';

import 'package:domain/entity/wallet_credentials_list/wallet_credentials_list_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
          color: Colors.redAccent,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Added Date',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('${credentialCard.addedOn}',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.normal)),
            const SizedBox(height: 10),
            const Text('VC Type',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('${getData!['vc']['type'].join(', ')}',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.normal)),
            const SizedBox(height: 10),
            const Text('Issuer',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            // const SizedBox(height: 5),
            _buildIssuerList(getData['iss']),
            const SizedBox(height: 10),
            const Text('Credential Subjects',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            _buildCredentialList(getData['vc']['credentialSubject']),

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
      return components.sublist(2).join(':');
    } else {
      return 'Invalid DID format';
    }
  }

  Widget _buildCredentialList(Map<String, dynamic> items) {
    List<Widget> itemWidgets;
    if (items['achievement'] != null) {
      itemWidgets = [
        Text(
          'Name : ${items['achievement']['name']}',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Description : ${items['achievement']['description']}',
          style: const TextStyle(fontSize: 16),
        ),
      ];
    } else {
      // Create a list of Text widgets for each key-value pair
      itemWidgets = items.entries.map((entry) {
        return Text(
          '${entry.key}: ${entry.value}',
          style: const TextStyle(fontSize: 16),
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
