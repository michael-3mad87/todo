import 'package:flutter/material.dart';
import 'package:todo/app_them.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.label, required this.onpressed});
  String label;
  VoidCallback onpressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(fontSize: 20, color: AppTheme.white),
      ),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * .06),
      ),
    );
  }
}
