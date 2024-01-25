import 'package:absensi_mattaher/model/user_profile.dart';
import 'package:absensi_mattaher/repositories/user_repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserDetailsState {}

class UserDetailsInitial extends UserDetailsState {}

class UserDetailsFetchInProgress extends UserDetailsState {}

class UserDetailsFetchInSucces extends UserDetailsState {
  final UserProfile userProfile;

  UserDetailsFetchInSucces(this.userProfile);
}

class UserDetailsFetchInFailure extends UserDetailsState {
  final String errorMessage;

  UserDetailsFetchInFailure(this.errorMessage);
}

class UserDetailsCubit extends Cubit<UserDetailsState> {
  UserDetailsCubit() : super(UserDetailsInitial());

  void fetchUserDetails() async {
    emit(UserDetailsFetchInProgress());

    try {
      UserProfile userProfile = await UserRepositories().userProfileInfo();
      emit(UserDetailsFetchInSucces(userProfile));
    } catch (e) {
      emit(UserDetailsFetchInFailure(e.toString()));
    }
  }
}
