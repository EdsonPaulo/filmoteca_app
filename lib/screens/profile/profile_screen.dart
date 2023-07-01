import 'package:filmoteca_app/models/user_model.dart';
import 'package:filmoteca_app/screens/auth/authentication_bloc.dart';
import 'package:filmoteca_app/utils/string_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:filmoteca_app/shared/widgets/custom_appbar.dart';
import 'package:get_it/get_it.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthenticationBloc _authBloc = GetIt.instance<AuthenticationBloc>();

  Widget _profileButton({
    required String label,
    required IconData iconData,
    Function()? onPressed,
  }) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStatePropertyAll(Colors.grey.shade700),
      ),
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
        child: StreamBuilder(
          stream: _authBloc.userDataStream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              UserModel userData = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.blue,
                    child: Text(
                      getNameInitials(userData.name),
                      style: const TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    userData.name,
                    style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    userData.email,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
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
                              onPressed: () {
                                Navigator.of(context).pushNamed('/language');
                              },
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
                                _authBloc.logout();
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
              );
            } else {
              return const CircularProgressIndicator(
                color: AppColors.primaryColor,
              );
            }
          },
        ),
      ),
    );
  }
}
