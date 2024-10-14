import 'package:domain/entity/wallet_credentials_list/wallet_credentials_list_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CredentialCard extends StatelessWidget {
  final WalletCredentialListEntity credentialCard;

  CredentialCard({
    Key? key,
       required this.credentialCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Map<String, dynamic>?  getData =  credentialCard.document;

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
            const Text('Added Date', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('${credentialCard.addedOn}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
            const SizedBox(height: 10),
            const Text('VC Type', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('${getData!['vc']['type'].join(', ')}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
            Text('VC Id- ${getData['vc']['id']}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            const Text('Issuer', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            _buildIssuerList(getData['vc']['issuer']),
            const SizedBox(height: 10),
            const Text('Credential Subjects', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
            ],
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildIssuerList(Map<String, dynamic> items) {
     return Column(
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Issuer Type- ${items['type']?.isEmpty ?? true ? 'N/A' : items['type'][0]}', style: const TextStyle(fontSize: 16)),
        Text('Issuer Id- ${items['id'] ?? 'N/A'}', style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildCredentialList(Map<String, dynamic> items) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Type- ${items['achievement']?['type']?[0] ?? 'N/A'}', style: const TextStyle(fontSize: 16)),
        Text('Id- ${items['id'] ?? 'N/A'}', style: const TextStyle(fontSize: 16)),
        Text('Description- ${items['achievement']?['description'] ?? 'N/A'}', style: const TextStyle(fontSize: 16)),

      ],
    );
  }

}
