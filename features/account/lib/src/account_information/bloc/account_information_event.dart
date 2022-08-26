part of 'account_information_bloc.dart';

abstract class AccountInformationEvent {
  const AccountInformationEvent();
}

class UserChanged extends AccountInformationEvent {
  final User user;

  const UserChanged({
    required this.user,
  });
}

class ChangeProfileAction extends AccountInformationEvent {
  const ChangeProfileAction();
}

class ChangePasswordAction extends AccountInformationEvent {
  const ChangePasswordAction();
}

class DeleteAccountAction extends AccountInformationEvent {
  const DeleteAccountAction();
}
