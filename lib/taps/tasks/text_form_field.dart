import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxlines = 1,
    required this.validator,
    this.isPassword = false,
  });
  TextEditingController controller = TextEditingController();
 String hintText;
 int? maxlines;
 bool isPassword = false ;

  final String? Function(String?)? validator;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isObscure = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  isObscure = !isObscure;
                  setState(() {});
                },
                icon: isObscure
                    ? const Icon(
                        Icons.visibility_off_outlined,
                      )
                    : const Icon(
                        Icons.visibility_outlined,
                      ),
              )
            : null,
      ),
      maxLines: widget.maxlines,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: isObscure,
    );
  }
}
