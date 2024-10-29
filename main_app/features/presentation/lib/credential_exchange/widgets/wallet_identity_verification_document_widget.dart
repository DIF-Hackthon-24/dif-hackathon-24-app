import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';

class DocumentUploadWidget extends StatefulWidget {
  Function submitButtonPressed;

  DocumentUploadWidget({required this.submitButtonPressed, super.key});

  @override
  _DocumentUploadWidgetState createState() => _DocumentUploadWidgetState();
}

class _DocumentUploadWidgetState extends State<DocumentUploadWidget> {
  String? _fileName;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
      });
    }
  }

  void _submitDocument() {
    if (_fileName != null) {
      widget.submitButtonPressed.call();
    } else {
      showSessionExpiredToast('Please upload a document before submitting.');
    }
  }

  void _clearFile() {
    setState(() {
      _fileName = null;
    });
  }
  void showSessionExpiredToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PSImage(
            PSImageModel(
              iconPath: 'assets/images/undraw_going_up_re_86kg.svg',
              height: 250,
            ),
          ), // Ensure you have an image asset
          const SizedBox(height: 20),
          const Text(
            'Almost there! Simply upload a scan of your Passport photo page',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          GestureDetector(
            onTap: _fileName == null ? _pickFile : _clearFile,
            child: Container(
              decoration: BoxDecoration(border: Border.all()),
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    _fileName ?? 'Please select document',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 20),
                  Icon(_fileName == null ? Icons.upload_file : Icons.close),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildCTAButton(
            context,
            icon: Icons.upload,
            title: 'Upload Passport Document',
            onTap: _submitDocument,
          ),
        ],
      ),
    );
  }

  Widget _buildCTAButton(BuildContext context,
      {required IconData icon, required String title, required VoidCallback onTap}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(
          color: Colors.blue, // Set the border color here
          width: 2.0,         // Set the border width here
        ),

      ),
      child: ListTile(
        trailing: Icon(icon, color: Theme.of(context).primaryColor),
        title: Center(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black))),
        onTap: onTap,
      ),
    );
  }
}
