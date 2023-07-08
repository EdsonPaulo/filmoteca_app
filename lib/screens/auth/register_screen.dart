// ignore_for_file: use_build_context_synchronously
import 'package:filmoteca_app/models/user_model.dart';
import 'package:filmoteca_app/shared/widgets/custom_text_form_field.dart';
import 'package:filmoteca_app/utils/app_toasts.dart';
import 'package:filmoteca_app/utils/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:filmoteca_app/shared/widgets/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  bool isSubmiting = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;

      try {
        setState(() {
          isSubmiting = true;
        });

        UserModel? user;
        /**
         *  = await firebaseSignUp(
          name: name,
          email: email,
          password: password,
        );
       */

        if (user != null) {
          _nameController.clear();
          _emailController.clear();
          _passwordController.clear();

          showToast(
              context: context,
              message: 'Conta Criada com sucesso!',
              type: ToastType.success);

          Navigator.pushNamed(context, '/login');
        } else {
          showToast(
              context: context,
              message: 'Ocorreu um erro ao criar conta',
              type: ToastType.danger);
        }
      } catch (e) {
        print(e);
        showToast(
          context: context,
          message: e.toString(),
          type: ToastType.danger,
        );
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
        backgroundColor: const Color(0xFF181A1F),
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
                    'Criar Conta',
                    style: TextStyle(
                      fontSize: 34,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomTextFormField(
                    label: 'Nome e Sobrenome',
                    leftIcon: CupertinoIcons.person,
                    controller: _nameController,
                    validator: (value) =>
                        value!.isEmpty ? 'Campo obrigatório!' : null,
                  ),
                  const SizedBox(height: 15),
                  CustomTextFormField(
                    label: 'Email',
                    leftIcon: CupertinoIcons.mail,
                    controller: _emailController,
                    validator: (value) => value!.isEmpty
                        ? 'Campo obrigatório!'
                        : !isValidEmail(value)
                            ? 'Informe um email válido!'
                            : null,
                  ),
                  const SizedBox(height: 15),
                  CustomTextFormField(
                    isPassword: true,
                    label: 'Palavra-Passe',
                    leftIcon: Icons.lock_outline,
                    controller: _passwordController,
                    validator: (value) =>
                        value!.isEmpty ? 'Campo obrigatório!' : null,
                  ),
                  const SizedBox(height: 15),
                  CustomTextFormField(
                    isPassword: true,
                    label: 'Confirmar Palavra-passe',
                    leftIcon: Icons.lock_outline,
                    controller: _confirmPassController,
                    validator: (value) => value!.isEmpty
                        ? 'Campo obrigatório!'
                        : value != _passwordController.text
                            ? 'As palavras-passe não conferem'
                            : null,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    label: 'Criar Conta',
                    loading: isSubmiting,
                    onPressed: () => _submitForm(context),
                  ),
                  const SizedBox(height: 70),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Já tem uma Conta?  ',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          SizedBox(width: 5), // espaço entre os dois textos
                          Text(
                            'Iniciar Sessão',
                            style: TextStyle(fontSize: 16, color: Colors.green),
                          ),
                        ],
                      )),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
