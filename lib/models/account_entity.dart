class AccountEntity {
  String serial;
  String username;
  String password;
  bool showPassword;
  bool canEdit;

  AccountEntity({
    this.serial = '',
    required this.username,
    required this.password,
    this.showPassword = true,
    this.canEdit = true,
  });
}
