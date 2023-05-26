import 'package:demo/models/account_entity.dart';
import 'package:flutter/material.dart';

class MyAppProvider extends ChangeNotifier {
  int viewIndex = 0;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  int currentStep = 0;
  bool isHidePassword = true;
  List<AccountEntity> listAccount = [];
  bool allowSave = false;
  bool isDisappear = false;

  void setViewIndex({required int index}) {
    viewIndex = index;
    notifyListeners();
  }

  void setAutoValidateMode({required AutovalidateMode autoValidateMode}) {
    autoValidateMode = autoValidateMode;
    notifyListeners();
  }

  void setCurrentStep({required int index}) {
    currentStep = index;
    notifyListeners();
  }

  void changeIsHidePassword() {
    isHidePassword = !isHidePassword;
    notifyListeners();
  }

  void addToAccountList({required AccountEntity account}) {
    listAccount.add(account);
    notifyListeners();
  }

  void changeIsDisappear() {
    isDisappear = !isDisappear;
    notifyListeners();
  }

  void changeAllowSave() {
    allowSave = !allowSave;
    notifyListeners();
  }

  void resetAddView() {
    viewIndex = 0;
    autoValidateMode = AutovalidateMode.disabled;
    currentStep = 0;
    isHidePassword = true;
    isDisappear = false;
    allowSave = false;
    notifyListeners();
  }
}
