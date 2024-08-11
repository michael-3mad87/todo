import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
    CustomTextFormField({super.key, required this.controller, required this.hintText,this .maxlines ,required this.validator });
  TextEditingController controller = TextEditingController();
  String hintText;
  int? maxlines;

final String? Function(String?)?validator ;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText ),
      maxLines: maxlines,
      validator:validator ,
    );
  }
}
