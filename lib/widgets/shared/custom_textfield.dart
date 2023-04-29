import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final IconData? leftIcon;
  final bool? isPassword;
  final void Function(String) onChangeText;

  const CustomTextField({
    super.key,
    required this.label,
    required this.onChangeText,
    this.isPassword,
    this.leftIcon,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 325,
      height: 50,
      child: TextField(
          onChanged: widget.onChangeText,
          obscureText: widget.isPassword == true && !_showPassword,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: widget.label,
            hintStyle: const TextStyle(color: Colors.white70),
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: const Color(0xFF2A2D38),
            prefixIcon: Icon(widget.leftIcon, color: Colors.white70),
            suffixIcon: widget.isPassword == true
                ? IconButton(
                    icon: Icon(
                        color: Colors.white70,
                        _showPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    })
                : null,
          )),
    );
  }
}
