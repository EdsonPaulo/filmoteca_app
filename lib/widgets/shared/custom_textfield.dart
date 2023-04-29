import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {
  final bool isObscure;
  final String label;
  final Icon icon;

  const CustomTextField({

    required this.isObscure,
    required this.label,


  });
  
  @override
  Widget build(BuildContext context) {
    return TextField(

      style: const TextStyle(color: Color(0xFFC4C4C4)),

        obscureText: isObscure,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(color: Color(0xFFC4C4C4)),
          prefixIcon: const Icon(Icons.lock_outline,
              color: Color(0xFFC4C4C4)),
          
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Color(0xFF2A2D38),
        ),             
    );
  }

}