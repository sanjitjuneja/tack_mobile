library page_stack_controller;

import 'dart:async';

import 'package:app_dialog/app_dialog.dart';
import 'package:flutter/material.dart';

import '../exception/navigation_exception.dart';
import '../page_completer.dart';

part 'page_stack_progress_dialog_controller.dart';

mixin PageStackController on ChangeNotifier {
  final List<Page<dynamic>> _pages = <Page<dynamic>>[];

  List<Page<dynamic>> get pages => List<Page<dynamic>>.unmodifiable(_pages);

  final List<PageCompleter<dynamic>> _pageCompleters =
      <PageCompleter<dynamic>>[];

  void push(Page<dynamic> page) {
    _pages.add(page);
    notifyListeners();
  }

  Future<T> pushForResult<T>(Page<dynamic> page) {
    _pageCompleters.add(PageCompleter<T>(pageId: page.hashCode));
    push(page);

    return _pageCompleters.last.completer.future as Future<T>;
  }

  void completeLastWithResult(dynamic result) {
    _pageCompleters.last.completer.complete(result);
  }

  void popWithResult(dynamic result) {
    if (!_pageCompleters.last.completer.isCompleted) {
      _pageCompleters.last.completer.complete(result);
    }
    _pageCompleters.removeLast();
    pop();
  }

  void onPopResultDispatch(List<Page<dynamic>> pages) {
    if (_pageCompleters.isEmpty) return;

    if (pages.last.hashCode == _pageCompleters.last.pageId) {
      if (!_pageCompleters.last.completer.isCompleted) {
        // TODO: refactor name check to page return type check.
        if (pages.last.name == AppAlertDialog.routeName) {
          _pageCompleters.last.completer.complete(false);
        } else {
          _pageCompleters.last.completer.complete(null);
        }
      }
      _pageCompleters.removeLast();
    }
  }

  void pushAll(List<Page<dynamic>> pages) {
    _pages.addAll(pages);
    notifyListeners();
  }

  void removeNamed(String routeName) {
    _pages.removeWhere((Page element) => element.name == routeName);
    notifyListeners();
  }

  void remove(Page<dynamic> page) {
    _pages.remove(page);
    notifyListeners();
  }

  void replace(Page<dynamic> page) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
      push(page);
    } else {
      push(page);
    }
  }

  Future<T> replaceForResult<T>(Page<dynamic> page) {
    if (_pages.isNotEmpty) _pages.removeLast();

    return pushForResult(page);
  }

  void replaceLastWith(List<Page<dynamic>> pages) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
      pushAll(pages);
    } else {
      pushAll(pages);
    }
  }

  void resetTo(Page<dynamic> page) {
    _pages
      ..clear()
      ..add(page);
    notifyListeners();
  }

  void popUntil(String pageName) {
    final int index = _pages.indexWhere((Page<dynamic> page) {
      return page.name == pageName;
    });
    switch (index) {
      case -1:
        throw NavigationException(
          message: 'PageName $pageName '
              'is not found on the stack of $runtimeType',
        );
    }
    _pages.removeRange(index + 1, _pages.length);
    notifyListeners();
  }

  void popUntilPage(Page<dynamic> untilPage) {
    final int index = _pages.indexWhere((Page<dynamic> page) {
      return page.name == untilPage.name;
    });
    switch (index) {
      case -1:
        throw NavigationException(
          message: 'PageName ${untilPage.name} '
              'is not found on the stack of $runtimeType',
        );
    }
    _pages.removeRange(index + 1, _pages.length);
    notifyListeners();
  }

  void pop() {
    _pages.removeLast();
    notifyListeners();
  }

  void resetToFirst() {
    _pages.removeRange(1, _pages.length);
    notifyListeners();
  }

  void autoPop() {
    if (_pageCompleters.isNotEmpty &&
        pages.last.hashCode == _pageCompleters.last.pageId) {
      popWithResult(null);
    } else {
      pop();
    }
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
