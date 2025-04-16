import 'package:equatable/equatable.dart';

class SplashState extends Equatable {
  final int currentPage;

  const SplashState({this.currentPage = 0});

  SplashState copyWith({int? currentPage}) {
    return SplashState(currentPage: currentPage ?? this.currentPage);
  }

  @override
  List<Object?> get props => [currentPage];
}
