import 'package:filmoteca_app/widgets/shared/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:filmoteca_app/utils/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkPrimaryColor,
      appBar: const CustomHomeAppBar(),
      body: Center(
        //padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*Text(
                'PERFIL',
                style: TextStyle(color: AppColors.primaryColor),
              ),*/
            const SizedBox(height: 40),
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue,
              child: Text(
                'WC',
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Walter Carrillo',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
            const Text(
              'walca.23@gmail.com',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 48),
            Container(
              width: 390,
              height: 381,
              decoration: const BoxDecoration(
                color: Color(0xFF23252D),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Adicione aqui os widgets que você deseja exibir dentro da Column
                  SizedBox(height: 10),

                  TextButton(
                    onPressed: () {
                      // Adicione aqui o código que deve ser executado quando o botão for pressionado
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.language_outlined, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Linguagem",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios, color: Colors.white),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),

                  TextButton(
                    onPressed: () {
                      // Adicione aqui o código que deve ser executado quando o botão for pressionado
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.edit_square, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Editar Perfil",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios, color: Colors.white),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),

                  TextButton(
                    onPressed: () {
                      // Adicione aqui o código que deve ser executado quando o botão for pressionado
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.settings_outlined, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Configurações",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios, color: Colors.white),
                      ],
                    ),
                  ),
                  //SizedBox(height: 10),

                  TextButton(
                    onPressed: () {
                      // Adicione aqui o código que deve ser executado quando o botão for pressionado
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.info_outline, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Ajuda & Perguntas Frequentes",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios, color: Colors.white),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),

                  SizedBox(
                      width: 331,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                          // Adicione aqui o código que deve ser executado quando o botão for pressionado
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(0),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(
                                  color: Color(0xFF3F4250), width: 1),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Terminar Sessão",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFFD8F8F),
                              fontWeight: FontWeight.w400),
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
