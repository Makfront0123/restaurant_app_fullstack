import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/profile/domain/usecases/update_profile.dart';
import 'package:restaurant_bloc_frontend/features/profile/presentation/blocs/profile_event.dart';
import 'package:restaurant_bloc_frontend/features/profile/presentation/blocs/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdateProfileUsecase _updateProfile;
  ProfileBloc({
    required UpdateProfileUsecase updateProfile,
  })  : _updateProfile = updateProfile,
        super(ProfileInitial()) {
    on<UpdateProfileEvent>(_onUpdateProfile);
  }

  void _onUpdateProfile(
      UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      await _updateProfile.updateProfile(
          event.username, event.confirmPassword, event.password, event.token);
      emit(ProfileUpdated('Profile updated successfully'));
    } catch (e) {
      emit(ProfileError('Error updating profile: $e'));
    }
  }
}
