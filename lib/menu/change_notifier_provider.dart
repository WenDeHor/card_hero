//import 'package:flutter/material.dart';
//
//class ChangeNotifierProvider<T extends ChangeNotifier>
//    extends InheritedNotifier<T> {
//  ChangeNotifierProvider({
//    Key? key,
//    required T model,
//    required Widget child,
//  }) : super(
//    key: key,
//    notifier: model,
//    child: child,
//  );
//
//  static T? watch<T extends ChangeNotifier>(BuildContext context) {
//    return context
//        .dependOnInheritedWidgetOfExactType<ChangeNotifierProvider<T>>()
//        ?.notifier;
//  }
//
//  static T? read<T extends ChangeNotifier>(BuildContext context) {
//    final widget = context
//        .getElementForInheritedWidgetOfExactType<ChangeNotifierProvider<T>>()
//        ?.widget;
//    if (widget is ChangeNotifierProvider<T>) {
//      return widget.notifier;
//    } else {
//      return null;
//    }
//  }
//}