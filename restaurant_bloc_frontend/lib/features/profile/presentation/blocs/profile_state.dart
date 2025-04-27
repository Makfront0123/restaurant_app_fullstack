import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileUpdated extends ProfileState {
  final String message;

  ProfileUpdated(this.message);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}
