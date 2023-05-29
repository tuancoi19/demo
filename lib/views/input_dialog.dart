import 'package:flutter/material.dart';

class InputDialog extends StatelessWidget {
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  final Function(String) onSave;

  const InputDialog({
    Key? key,
    required this.controller,
    required this.formKey,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.clear();
        return true;
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: const Text('Nhập STK'),
        content: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  maxLength: 16,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng nhập mã thẻ';
                    }
                    if (!RegExp(r'\d').hasMatch(value)) {
                      return 'Chỉ nhập kí tự số';
                    }
                    if (value.trim().length < 16) {
                      return 'Mã thẻ phải dài 16 kí tự';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelText: 'STK',
                  ),
                ),
                const SizedBox(height: 28),
                buildButton(
                  title: 'Save',
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.of(context).pop();
                      onSave(controller.text.trim());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButton({
    required String title,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.blue,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
