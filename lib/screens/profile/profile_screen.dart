import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:filmoteca_app/shared/widgets/custom_appbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Widget _profileButton({
    required String label,
    required IconData iconData,
    Function()? onPressed,
  }) {
    return TextButton(
      style: ButtonStyle(
          overlayColor: MaterialStatePropertyAll(Colors.grey.shade700)),
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(iconData, color: Colors.white),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400),
          ),
          const Spacer(),
          const Icon(
            CupertinoIcons.chevron_right,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkPrimaryColor,
      appBar: const CustomHomeAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            const SizedBox(height: 40),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: const BoxDecoration(
                  color: AppColors.darkSecondaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      _profileButton(
                        label: "Linguagem",
                        iconData: CupertinoIcons.globe,
                        onPressed: () {},
                      ),
                      const SizedBox(height: 10),
                      _profileButton(
                        label: "Editar Perfil",
                        iconData: CupertinoIcons.pencil_outline,
                        onPressed: () {},
                      ),
                      const SizedBox(height: 10),
                      _profileButton(
                        label: "Configurações",
                        iconData: CupertinoIcons.settings,
                        onPressed: () {},
                      ),
                      const SizedBox(height: 10),
                      _profileButton(
                        label: "Ajuda & FAQ",
                        iconData: CupertinoIcons.info_circle,
                        onPressed: () {},
                      ),
                    ]),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/welcome');
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.all(12.0),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            Colors.transparent,
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: const BorderSide(
                                width: 2,
                                color: Color.fromARGB(255, 80, 63, 63),
                              ),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Terminar Sessão",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}