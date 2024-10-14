import 'package:domain/entity/wallet_credentials_list/wallet_credentials_list_entity.dart';
import 'package:flutter/material.dart';
import 'package:presentation/wallet_credentials_list/widgets/wallet_credentials_card_widget.dart';
import 'package:widget_library/ps_scaffold.dart';

class WalletCredListWidget extends StatefulWidget {
  final List<WalletCredentialListEntity?> credentialListItems;
  final Function onRefresh;
  final Function(String, bool) onDelete;

  WalletCredListWidget(
      {Key? key, required this.credentialListItems, required this.onRefresh, required this.onDelete})
      : super(key: key);

  @override
  _WalletCredListWidgetState createState() => _WalletCredListWidgetState();
}

class _WalletCredListWidgetState extends State<WalletCredListWidget> {
  late List<WalletCredentialListEntity?> currentItems;

  @override
  void initState() {
    super.initState();
    currentItems = widget.credentialListItems;
  }

  Future<void> refreshList() async {
    await widget.onRefresh.call();
  }

  Future<void> onDelete(String credentialId, bool isPermanent) async {
    await widget.onDelete.call(credentialId,isPermanent);
  }

  @override
  Widget build(BuildContext context) {
    return PSScaffold(
      body: widget.credentialListItems.isEmpty
          ? const Center(
              child: Text('No record found',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: widget.credentialListItems.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.green,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20.0),
                    child: const Text(
                      'Soft Delete',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20.0),
                    child: const Text(
                      'Hard Delete',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  onDismissed: (direction) async{
                    var isPermanent = direction == DismissDirection.startToEnd ? false : true;
                    await  onDelete(widget.credentialListItems[index]!.id ?? '', isPermanent);
                    setState(() {
                      widget.credentialListItems.removeAt(index);
                    });
                  },
                  child: Column(
                    children: [
                      CredentialCard(
                        credentialCard: widget.credentialListItems[index]!,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await refreshList();
        },
        tooltip: 'Refresh List',
        child: const Icon(
          Icons.refresh,
          color: Colors.orange,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
