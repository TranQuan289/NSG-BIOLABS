import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../utilities/rest_api_client/api_client.dart';
import '../forgot_password_submit/forgot_password_submit_screen.dart';
import 'bloc/forgot_password_bloc.dart';
import 'index.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ForgotPasswordBloc(ForgotPasswordRepository(RestAPIClient())),
        child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            switch (state.runtimeType) {
              case ForgotPasswordSuccess:
                openForgotPasswordSubmit(context);
                break;
              default:
            }
          },
          builder: (context, state) {
            final bloc = context.read<ForgotPasswordBloc>();
            return Scaffold(
              backgroundColor: primaryColor,
              body: Stack(
                children: [
                  const HeaderLogin(),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 130,
                        ),
                        const PrimaryImage(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Text(
                            'Forgot Password',
                            style: normalBlackTextStyle,
                          ),
                        ),
                        BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                            builder: (context, state) {
                          switch (state.runtimeType) {
                            case ForgotPasswordError:
                              return ErrorMessage(
                                  message: (state as ForgotPasswordError).messageError.toString());
                            default:
                          }
                          return const SizedBox();
                        }),
                        Form(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Email',
                                  style: normalBlackTextStyle,
                                ),
                                TextFormFieldWidget(
                                  isEnabled: true,
                                  textCotroller: bloc.emailCotroller,
                                  hintLabel: 'Email',
                                  iconPassword: false,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SubmitButton(onPressed: () => onForgotPassword(context)),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 28.0),
                          child: BackToLoginTextButton(
                            onPressed: () => backToLogin(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }

  openForgotPasswordSubmit(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgotPasswordSubmitScreen()),
    );
  }

  backToLogin(BuildContext context) {
    Navigator.pop(context);
  }

  onForgotPassword(BuildContext context) {
    final bloc = context.read<ForgotPasswordBloc>();
    bloc.add(ForgotPasswordRequest(email: bloc.emailCotroller.text.trim()));
  }
}
