import 'package:demo/models/account_entity.dart';
import 'package:demo/providers/app_provider.dart';
import 'package:demo/views/add_form_field.dart';
import 'package:demo/views/ask_question_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddView extends StatefulWidget {
  const AddView({Key? key}) : super(key: key);

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();
  late MyAppProvider _provider;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    _provider = context.read<MyAppProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppProvider>(
      builder: (context, value, child) {
        return Stepper(
          currentStep: value.currentStep,
          steps: stepList(
            autoValidateMode: value.autoValidateMode,
            isHidePassword: value.isHidePassword,
            isDisappear: value.isDisappear,
            allowSave: value.allowSave,
          ),
          onStepContinue: () {
            onStepContinue(
              currentStep: value.currentStep,
              allowSave: value.allowSave,
            );
          },
          onStepCancel: () {
            _provider.setCurrentStep(index: value.currentStep - 1);
            if (!value.isHidePassword) {
              _provider.changeIsHidePassword();
            }
            if (value.isDisappear) {
              _provider.changeIsDisappear();
            }
            if (value.allowSave) {
              _provider.changeAllowSave();
            }
          },
          controlsBuilder: (context, details) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ElevatedButton(
                  onPressed: details.onStepContinue,
                  child: Text(value.currentStep == 0 ? 'Confirm' : 'Save'),
                ),
                if (value.currentStep != 0)
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: const Text(
                      'Back',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  List<Step> stepList({
    required AutovalidateMode autoValidateMode,
    required bool isHidePassword,
    required bool isDisappear,
    required bool allowSave,
  }) {
    return [
      Step(
        title: const Text('Thêm tài khoản mới'),
        content: Form(
          key: _formKey,
          autovalidateMode: autoValidateMode,
          child: AddFormField(
            usernameController: usernameController,
            passwordController: passwordController,
            onDoubleTapPassword: () {
              _provider.changeIsHidePassword();
            },
            isHidePassword: isHidePassword,
          ),
        ),
      ),
      Step(
        title: const Text('Hỏi tí'),
        content: AskQuestionView(
          onTap: () {
            _provider.changeAllowSave();
          },
          onPan: () {
            _provider.changeIsDisappear();
          },
          isDisappear: isDisappear,
          allowSave: allowSave,
        ),
      ),
    ];
  }

  void onStepContinue({
    required int currentStep,
    required bool allowSave,
  }) {
    if (currentStep == 0) {
      _provider.setAutoValidateMode(autoValidateMode: AutovalidateMode.always);
      if (_formKey.currentState!.validate()) {
        _provider.setCurrentStep(index: currentStep + 1);
      }
    }
    if (currentStep == 1 && allowSave) {
      _provider.addToAccountList(
        account: AccountEntity(
          username: usernameController.text,
          password: passwordController.text,
        ),
      );
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Thành công'),
          content: const Text('Thêm tài khoản thành công.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cảm ơn!'),
              onPressed: () {
                _provider.resetAddView();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }
}
