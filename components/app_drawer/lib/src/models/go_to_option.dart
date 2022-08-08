enum GoToOption {
  account,
  previousTacks,
  groups,
  invitations,
  withdraw,
  customerSupport,
  termsAndConditions,
  privacyPolicy,
}

extension GoToOptionToTitleKey on GoToOption {
  String get titleKey {
    return 'drawer.options.$name';
  }
}
