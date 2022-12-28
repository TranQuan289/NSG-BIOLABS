import 'package:codebase/screens/change_password/change_password_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../utilities/rest_api_client/api_client.dart';
import '../login/widgets/index.dart';
import 'bloc/change_password_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordBloc(ChangePasswordRepository(RestAPIClient())),
      child: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case ChangePasswordNotify:
              ReusableDialog.show(context,
                  title: (state as ChangePasswordNotify).title.toString(),
                  body: state.body.toString(),
                  labelRight: 'OK',
                  onPressRight: () => Navigator.pop(context));
              break;
            default:
          }
        },
        builder: (context, state) {
          final bloc = context.read<ChangePasswordBloc>();
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () => onBack(context),
                  icon: Icon(Icons.arrow_back_ios_new_outlined, color: blackColor)),
              title: Text(
                'Change Password',
                style: titleAppBarTextStyle,
              ),
              elevation: 1,
              centerTitle: true,
              backgroundColor: primaryColor,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const TextWidget(label: 'Current password'),
                    TextFormFieldWidget(
                      isEnabled: true,
                      hintLabel: 'Current Password',
                      iconPassword: true,
                      textCotroller: bloc.currentPasswordCotroller,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const TextWidget(label: 'New password'),
                    TextFormFieldWidget(
                      isEnabled: true,
                      hintLabel: 'New Password',
                      iconPassword: true,
                      textCotroller: bloc.newPasswordCotroller,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const TextWidget(label: 'Confirm New password'),
                    TextFormFieldWidget(
                      isEnabled: true,
                      hintLabel: 'Confirm New Password',
                      iconPassword: true,
                      textCotroller: bloc.confirmPasswordCotroller,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ChangePasswordButton(
                      onPressed: () => onChangePassword(context),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  onBack(BuildContext context) {
    Navigator.pop(context);
  }

  onChangePassword(BuildContext context) {
    final bloc = context.read<ChangePasswordBloc>();
    bloc.add(ChangePassword(
        currentPassword: bloc.currentPasswordCotroller.text.trim(),
        newPassword: bloc.newPasswordCotroller.text.trim(),
        newPasswordConfirmation: bloc.confirmPasswordCotroller.text.trim()));
  }

  onpenDialogNotify(BuildContext context) {}
}
