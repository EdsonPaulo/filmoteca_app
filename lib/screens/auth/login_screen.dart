// ignore_for_file: use_build_context_synchronously
import 'package:filmoteca_app/models/user_model.dart';
import 'package:filmoteca_app/screens/auth/authentication_bloc.dart';
import 'package:filmoteca_app/services/users.dart';
import 'package:filmoteca_app/shared/widgets/custom_text_form_field.dart';
import 'package:filmoteca_app/utils/app_toasts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:filmoteca_app/shared/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthenticationBloc _authBloc = GetIt.instance<AuthenticationBloc>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isSubmiting = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      try {
        setState(() {
          isSubmiting = true;
        });

        UserModel? user = await postSignIn(
          email: email,
          password: password,
        );

        if (user != null) {
          _authBloc.setUserData(user);
          _emailController.clear();
          _passwordController.clear();

          showToast(
              context: context,
              message: 'Sessão Iniciada com sucesso!',
              type: ToastType.success);

          Navigator.pushNamed(context, '/home');
        } else {
          showToast(
              context: context,
              message: 'Ocorreu um erro ao iniciar sessão',
              type: ToastType.danger);
        }
      } catch (e) {
        showToast(context: context, message: '$e', type: ToastType.danger);
      } finally {
        setState(() {
          isSubmiting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.darkPrimaryColor,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
      ),
      backgroundColor: AppColors.darkPrimaryColor,
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo_b.png'),
                    const SizedBox(height: 30),
                    const Text(
                      'Iniciar Sessão',
                      style: TextStyle(
                        fontSize: 34,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 50),
                    CustomTextFormField(
                      label: 'Email',
                      leftIcon: CupertinoIcons.mail,
                      controller: _emailController,
                      validator: (value) => value!.isEmpty
                          ? 'Por favor, digite seu e-mail'
                          : null,
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      isPassword: true,
                      label: 'Palavra-Passe',
                      leftIcon: Icons.lock_outline,
                      controller: _passwordController,
                      validator: (value) => value!.isEmpty
                          ? 'Por favor, digite a sua palavra-passe'
                          : null,
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      label: 'Entrar',
                      loading: isSubmiting,
                      onPressed: () => _submitLogin(context),
                    ),
                    const SizedBox(height: 70),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Não tem uma Conta?',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Criar Conta',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.green),
                            ),
                          ],
                        )),
                    const SizedBox(height: 70),
                  ]),
            ),
          ),
        );
      }),
    );
  }
}
