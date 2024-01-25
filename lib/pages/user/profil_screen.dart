import 'package:absensi_mattaher/pages/user/cubits/user_details_cubit.dart';
import 'package:absensi_mattaher/pages/user/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () => context.read<UserDetailsCubit>().fetchUserDetails(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: wAppBar(context, text: 'Profil'),
        body: BlocBuilder<UserDetailsCubit, UserDetailsState>(
          bloc: context.read<UserDetailsCubit>(),
          builder: (context, state) {
            if (state is UserDetailsFetchInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UserDetailsFetchInSucces) {
              return Center(
                child: Text('berhasil ${state.userProfile.namaLengkap}'),
              );
            } else if (state is UserDetailsFetchInFailure) {
              return Text('data failed');
            }
            return Container(
              child: Text('data'),
            );
          },
        ),
      ),
    );
  }
}
