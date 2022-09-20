part of page_stack_controller;

extension PageStackProgressDialogController on PageStackController {
  void pushProgress({String? messageKey}) {
    _pages.add(ProgressDialog.page(messageKey: messageKey));
    notifyListeners();
  }

  void popProgress() {
    final int lastProgressIndex = _pages.lastIndexWhere(
      (Page element) => element.name == ProgressDialog.routeName,
    );
    if (lastProgressIndex == -1) return;

    _pages.removeAt(lastProgressIndex);
    notifyListeners();
  }
}
