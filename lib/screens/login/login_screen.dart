import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../utilities/rest_api_client/api_client.dart';
import '../forgot_password/forgot_password_screen.dart';
import '../navigator/navigator_screen.dart';
import 'bloc/login_bloc.dart';
import 'login_repository.dart';
import 'widgets/index.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginBloc(LoginRepository(RestAPIClient())),
        child: BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
          switch (state.runtimeType) {
            case LoginSuccess:
              openNavigator(context);
              break;
            default:
          }
        }, builder: (context, state) {
          final bloc = context.read<LoginBloc>();
          return Scaffold(
            backgroundColor: primaryColor,
            body: Stack(
              children: [
                const HeaderLogin(),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 130,
                      ),
                      const PrimaryImage(),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: TextWidget(
                            label: 'Login',
                          )),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          switch (state.runtimeType) {
                            case LoginError:
                              return ErrorMessage(
                                  message: (state as LoginError).messageError.toString());
                            default:
                          }
                          return const SizedBox();
                        },
                      ),
                      Form(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const TextWidget(
                                label: 'Email',
                              ),
                              TextFormFieldWidget(
                                isEnabled: true,
                                hintLabel: 'Email',
                                iconPassword: false,
                                textCotroller: bloc.emailCotroller,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const TextWidget(
                                label: 'Password',
                              ),
                              TextFormFieldWidget(
                                isEnabled: true,
                                textCotroller: bloc.passwordCotroller,
                                hintLabel: 'Password',
                                iconPassword: true,
                              ),
                              const SizedBox(height: 28),
                              LoginButton(
                                onPressed: () => login(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 28.0),
                        child: ForgotPasswordTextButton(
                          onPressed: () => openForgot(context),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }));
  }

  openForgot(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()));
  }

  openNavigator(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => const NavigatorScreen()),
        (route) => false);
  }

  login(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    bloc.add(LoginRequested(
        email: bloc.emailCotroller.text.trim(), password: bloc.passwordCotroller.text.trim()));
  }
}
