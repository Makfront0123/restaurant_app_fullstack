import 'package:equatable/equatable.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/entities/user.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileUpdated extends ProfileState {
  final String message;
  final User updatedUser;

  ProfileUpdated(this.message, this.updatedUser);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}
