import 'package:filmoteca_app/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomHomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusBarHeight, left: 16, right: 16),
      height: preferredSize.height +
          statusBarHeight, // Adicione a altura da barra de status à altura total
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/logo_c.png',
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  CupertinoIcons.bell,
                  color: AppColors.primaryColor,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/notifications');
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
