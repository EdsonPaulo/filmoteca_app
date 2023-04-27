import 'package:filmoteca_app/constants/app_colors.dart';
import 'package:filmoteca_app/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryMoviesScreen extends StatefulWidget {
  final CategoryModel category;

  const CategoryMoviesScreen({super.key, required this.category});

  @override
  _CategoryMoviesScreenState createState() => _CategoryMoviesScreenState();
}

class _CategoryMoviesScreenState extends State<CategoryMoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDarkColor,
      appBar: AppBar(
          toolbarHeight: 80,
          elevation: 0,
          foregroundColor: AppColors.primaryColor,
          title: Text(widget.category.name.toUpperCase()),
          backgroundColor: AppColors.primaryDarkColor),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [],
        ),
      ),
    );
  }
}
