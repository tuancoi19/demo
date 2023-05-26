import 'package:demo/models/account_entity.dart';
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
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
      ),
    );
  }

  List<DataRow> buildRowList() {
    return List<DataRow>.generate(
      widget.accountList.length,
      (index) => DataRow(
        cells: <DataCell>[
          DataCell(
            widget.accountList[index].canEdit
                ? Form(
                    key: _formKey,
                    child: TextFormField(
                      // readOnly: widget.accountList[index].serial.isNotEmpty,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Vui lòng nhập mã thẻ';
                        }
                        if (value.trim().length < 16) {
                          return 'Mã thẻ phải dài 16 kí tự';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      maxLength: 16,
                      decoration: const InputDecoration(
                        counter: SizedBox(),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            widget.accountList[index].serial = value.trim();
                            widget.accountList[index].canEdit = false;
                          });
                        } else {
                          setState(() {
                            widget.accountList[index].canEdit = true;
                          });
                        }
                      },
                      controller: TextEditingController(
                        text: widget.accountList[index].serial,
                      ),
                    ),
                  )
                : const SizedBox(),
            showEditIcon: widget.accountList[index].canEdit,
            onTap: () {
              setState(() {
                widget.accountList[index].canEdit = false;
              });
            },
          ),
          DataCell(
            Text(widget.accountList[index].username),
          ),
          DataCell(
            StatefulBuilder(
              builder: (context, setState) {
                return TextFormField(
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
