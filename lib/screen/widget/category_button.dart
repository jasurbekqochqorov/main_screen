import 'package:flutter/material.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/styles/app_text_style.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({super.key, required this.title, required this.onTap, required this.isActive});

  final String title;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed:onTap,
        style: TextButton.styleFrom(
          padding:const  EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          backgroundColor: isActive? Colors.grey:AppColors.c_DBDBDE,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          title,
          style: AppTextStyle.interSemiBold.copyWith(color:(isActive)?AppColors.black:AppColors.black.withOpacity(0.4)),
        ),
      ),
    );
  }
}
