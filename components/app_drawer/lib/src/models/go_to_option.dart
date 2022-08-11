enum GoToOption {
  account,
  groups,
  invitations,
  previousTacks,
  deposit,
  withdraw,
  paymentSettings,
  customerSupport,
  termsAndConditions,
  privacyPolicy,
}

extension GoToOptionToTitleKey on GoToOption {
  String get titleKey {
    return 'drawer.options.$name';
  }
}
