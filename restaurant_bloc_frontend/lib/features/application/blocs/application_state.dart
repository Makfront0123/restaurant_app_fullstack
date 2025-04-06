import 'package:flutter/material.dart';

class ApplicationState {
  final int currentIndex;
  final List<Widget> pages;

  const ApplicationState({
    required this.currentIndex,
    required this.pages,
  });

  ApplicationState copyWith({
    int? currentIndex,
    List<Widget>? pages,
  }) {
    return ApplicationState(
      currentIndex: currentIndex ?? this.currentIndex,
      pages: pages ?? this.pages,
    );
  }
}
