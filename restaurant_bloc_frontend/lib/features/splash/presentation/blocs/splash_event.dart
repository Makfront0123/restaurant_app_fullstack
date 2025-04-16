import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class ChangePageEvent extends SplashEvent {
  final int pageIndex;

  const ChangePageEvent(this.pageIndex);

  @override
  List<Object> get props => [pageIndex];
}
