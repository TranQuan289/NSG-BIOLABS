import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_ui/shared_ui.dart';
import '../../utilities/rest_api_client/api_client.dart';
import '../../utilities/shared_preferences/shared_preferences.dart';
import '../../utilities/validation/validate.dart';
import '../change_password/change_password_screen.dart';
import '../login/login_screen.dart';
import 'bloc/profile_bloc.dart';
import 'profile_repository.dart';
import 'widget/text_profile_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProfileBloc(ProfileReponstory(RestAPIClient())),
        child: BlocConsumer<ProfileBloc, ProfileState>(listener: (context, state) {
          switch (state.runtimeType) {
            case ChangeProfileSuccess:
              onEditSuccess(context);
              break;
            default:
          }
        }, builder: (context, state) {
          if (state is ProfileInitial) {
            context.read<ProfileBloc>().add(FetchDataProfileEvent());
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProfileSuccess) {
            final bloc = context.read<ProfileBloc>();
            return Scaffold(
              appBar: AppBar(
                title: TextProfileWidget(
                  label: 'My Profile',
                  textStyle: titleAppBarTextStyle,
                ),
                elevation: 1,
                centerTitle: true,
                backgroundColor: primaryColor,
                actions: [
                  IconButton(
                      onPressed: () => onLogOut(context),
                      icon: Icon(
                        Icons.exit_to_app,
                        color: blackColor,
                      ))
                ],
              ),
              backgroundColor: primaryColor,
              body: Stack(
                children: [
                  const HeaderLogin(),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 19,
                        ),
                        CircleAvatar(
                          radius: 58,
                          backgroundImage: bloc.img != null
                              ? Image.file((bloc.img!)).image
                              : NetworkImage(bloc.avatar??''),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child:
                                EditPhotoTextButton(onPressed: () => openBottomSheetMenu(context))),
                        Form(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextProfileWidget(
                                  label: 'Name',
                                  textStyle: normalBlackTextStyle,
                                ),
                                TextFormFieldWidget(
                                  isEnabled: true,
                                  textCotroller: bloc.nameCotroller,
                                  hintLabel: 'Name',
                                  iconPassword: false,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextProfileWidget(
                                  label: 'Email',
                                  textStyle: normalBlackTextStyle,
                                ),
                                TextFormFieldWidget(
                                  isEnabled: false,
                                  textCotroller: bloc.emailCotroller,
                                  hintLabel: 'Email',
                                  iconPassword: false,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextProfileWidget(
                                  label: 'Company',
                                  textStyle: normalBlackTextStyle,
                                ),
                                TextFormFieldWidget(
                                  isEnabled: false,
                                  hintLabel: 'Company',
                                  iconPassword: false,
                                  textCotroller: bloc.companyCotroller,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextProfileWidget(
                                  label: 'Role',
                                  textStyle: normalBlackTextStyle,
                                ),
                                TextFormFieldWidget(
                                  textCotroller: bloc.roleCotroller,
                                  hintLabel: 'Role',
                                  iconPassword: false,
                                  isEnabled: true,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextProfileWidget(
                                  label: 'Phone Number',
                                  textStyle: normalBlackTextStyle,
                                ),
                                TextFormFieldWidget(
                                  textCotroller: bloc.phoneCotroller,
                                  isEnabled: true,
                                  hintLabel: 'Phone Number',
                                  iconPassword: false,
                                ),
                                const SizedBox(height: 20),
                                SaveButton(
                                  onPressed: () => onEdit(context),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 28.0),
                          child: ChangePasswordTextButton(
                            onPressed: () => openChangePassWord(context),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        }));
  }

  openChangePassWord(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordScreen()));
  }

  onEdit(BuildContext context) {
    final bloc = context.read<ProfileBloc>();
    switch (bloc.nameCotroller.text.trim()) {
      case '':
        ReusableDialog.show(
          context,
          title: validateName(bloc.nameCotroller.text.trim()),
          labelRight: 'OK',
          styleRight: normalGreenTextStyle,
          onPressRight: () => onBack(context),
        );
        break;
      default:
        bloc.add(ChangeProfile(
            name: bloc.nameCotroller.text,
            role: bloc.roleCotroller.text,
            phoneNumber: bloc.phoneCotroller.text));
    }
  }

  onLogOutConfirm(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
    clearToken();
  }

  onBack(BuildContext context) {
    Navigator.pop(context);
  }

  onLogOut(BuildContext context) {
    ReusableDialog.show(
      context,
      title: 'Logout?',
      labelLeft: 'Back',
      styleLeft: normalHintTextStyle,
      onPressLeft: () => onBack(context),
      labelRight: 'LOGOUT',
      styleRight: normalRedTextStyle,
      onPressRight: () => onLogOutConfirm(context),
    );
  }

  onEditSuccess(BuildContext context) {
    ReusableDialog.show(
      context,
      title: 'Profile Updated',
      body: 'Your profile has been updated.',
      labelRight: 'OK',
      styleRight: normalGreenTextStyle,
      onPressRight: () => onBack(context),
    );
  }
}

onEditFailure(BuildContext context) {}

openBottomSheetMenu(BuildContext context) {
  final bloc = context.read<ProfileBloc>();
  showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: 130.0,
          color: hideColor,
          child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          bloc.add(ChangeImage(0));
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Pick Image from camera',
                          style: normalBlackTextStyle,
                        )),
                    Divider(
                      color: blackColor,
                      thickness: 0.2,
                    ),
                    TextButton(
                        onPressed: () {
                          bloc.add(ChangeImage(1));
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Pick Image from gallery',
                          style: normalBlackTextStyle,
                        ))
                  ],
                ),
              )),
        );
      });
}
