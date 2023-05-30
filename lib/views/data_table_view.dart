import 'package:demo/models/account_entity.dart';
import 'package:demo/views/input_dialog.dart';
import 'package:flutter/material.dart';

class DataTableView extends StatefulWidget {
  final List<AccountEntity> accountList;

  const DataTableView({
    Key? key,
    required this.accountList,
  }) : super(key: key);

  @override
  State<DataTableView> createState() => _DataTableViewState();
}

class _DataTableViewState extends State<DataTableView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          border: TableBorder.all(color: Colors.black),
          columns: const <DataColumn>[
            DataColumn(
              label: Center(child: Text('STK')),
            ),
            DataColumn(
              label: Center(child: Text('Tên đăng nhập')),
            ),
            DataColumn(
              label: Center(child: Text('Mật khẩu')),
            ),
          ],
          rows: buildRowList(),
        ),
      ),
    );
  }

  List<DataRow> buildRowList() {
    return List<DataRow>.generate(
      widget.accountList.length,
      (index) => DataRow(
        cells: <DataCell>[
          DataCell(
            Text(widget.accountList[index].serial),
            showEditIcon: (widget.accountList[index].serial).isEmpty,
            onTap: (widget.accountList[index].serial).isEmpty
                ? () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return InputDialog(
                          controller: controller,
                          formKey: _formKey,
                          onSave: (value) async {
                            setState(() {
                              widget.accountList[index].serial = value;
                            });
                            await showAutoDismissDialog();
                          },
                        );
                      },
                    );
                  }
                : null,
          ),
          DataCell(
            Text(widget.accountList[index].username),
          ),
          DataCell(
            TextFormField(
              readOnly: true,
              obscureText: widget.accountList[index].showPassword,
              onTap: () {
                setState(() {
                  widget.accountList[index].showPassword =
                      !widget.accountList[index].showPassword;
                });
              },
              enableInteractiveSelection: false,
              controller: TextEditingController(
                text: widget.accountList[index].password,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showAutoDismissDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Tuyệt vời!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
    Future.delayed(
      const Duration(seconds: 1),
          () {
        Navigator.of(context).pop();
      },
    );
  }
}
