import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  _LanguageScreen createState() => _LanguageScreen();
}

class _LanguageScreen extends State<LanguageScreen> {
  final List<String> languages = [
    'Inglês',
    'Espanhol',
    'Francês',
    'Alemão',
    'Italiano',
    'Português',
    'Japonês',
    'Chinês',
    'Russo',
    'Árabe',
  ];

  String? _selectedLanguage;
  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadLanguage();
    print('Lingua inicia: $_selectedLanguage');
  }

//Loading Language value on start
  Future<void> _loadLanguage() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('selectedLanguage');
    });
  }

  Future<void> _setLanguage(String lang) async {
    //final prefs = await SharedPreferences.getInstance();
    setState(() {
      //_selectedLanguage = lang;
      _selectedLanguage = prefs.getString('selectedLanguage') ?? lang;
      prefs.setString('selectedLanguage', lang);
    });
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
        body: Container(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(children: [
            Container(
              alignment: Alignment.topCenter,
              child: const Text(
                'Linguagem',
                style: TextStyle(
                  fontSize: 32,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Encontre uma linguagem',
                      hintStyle: const TextStyle(color: Colors.white70),
                      prefixIcon: const Icon(Icons.search,
                          color: AppColors.primaryColor),
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF2A2D38),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final language = languages[index];
                  return ListTile(
                    title: Text(
                      language,
                      style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    onTap: () {
                      print('Clicou em $language');
                      _setLanguage(language);
                    },
                    tileColor: language == _selectedLanguage
                        ? Colors.blue.withOpacity(0.2)
                        : null,
                  );
                },
              ),
            )
          ]),
        ));
  }
}
