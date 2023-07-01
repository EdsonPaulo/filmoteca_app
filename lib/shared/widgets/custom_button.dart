import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

enum ButtonVariantType { primary, secondary }

class CustomButton extends StatelessWidget {
  final String label;
  final bool loading;
  final ButtonVariantType variant;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
    this.variant = ButtonVariantType.primary,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 4.0,
        backgroundColor: variant == ButtonVariantType.secondary
            ? Colors.white
            : AppColors.primaryColor,
        shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),
        minimumSize: const Size(325.0, 50.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
      child: loading
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
                strokeWidth: 3,
              ),
            )
          : Text(
              label,
              style: TextStyle(
                fontSize: 18.0,
                color: variant == ButtonVariantType.secondary
                    ? AppColors.primaryColor
                    : Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
    );
  }
}
