import 'package:flutter/material.dart';

class AddFormField extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final Function() onDoubleTapPassword;
  final bool isHidePassword;

  const AddFormField({
    Key? key,
    required this.usernameController,
    required this.passwordController,
    required this.onDoubleTapPassword,
    required this.isHidePassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: usernameController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập Tên đăng nhập';
            }
            if (value.contains(' ')) {
              return 'Vui lòng không nhập khoảng trắng';
            }
            if (value.length < 8 || value.length > 16) {
              return 'Tên đăng nhập phải có tối thiểu 8 kí tự và tối đa 16 kí tự';
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: 'Tên đăng nhập',
          ),
        ),
        InkWell(
          onDoubleTap: () {
            onDoubleTapPassword.call();
          },
          child: TextFormField(
            controller: passwordController,
            obscureText: isHidePassword,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Vui lòng nhập Mật khẩu';
              }
              if (value.trim().length < 8 || value.trim().length > 32) {
                return 'Mật khẩu phải có tối thiểu 8 kí tự và tối đa 32 kí tự';
              }
              final regex = RegExp(r'(?=.*\d)(?=.*[A-Z])');
              if (!regex.hasMatch(value)) {
                return 'Mật khẩu phải có ít nhất một chữ số và một kí tự viết hoa';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'Mật khẩu',
            ),
          ),
        ),
      ],
    );
  }
}
