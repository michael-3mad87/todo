import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_them.dart';
import 'package:todo/taps/setting/setting_provider.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    required this.validator,
    this.isPassword = false,
  });
  TextEditingController controller = TextEditingController();
 String hintText;
 int? maxLines;
 bool isPassword = false ;

  final String? Function(String?)? validator;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isObscure = false;
  @override
  Widget build(BuildContext context) {
        SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    return TextFormField(
      style:TextStyle(color: settingProvider.themMode == ThemeMode.light
                          ? AppTheme.darktItem
                          : AppTheme.white,) ,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: settingProvider.themMode == ThemeMode.light
                          ? AppTheme.darktItem
                          : AppTheme.white,),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  isObscure = !isObscure;
                  setState(() {});
                },
                icon: isObscure
                    ?  Icon(
                        Icons.visibility_off_outlined,
                        color: settingProvider.themMode == ThemeMode.light
                    ? AppTheme.darktItem
                    : AppTheme.white,
                      )
                    :  Icon(
                        Icons.visibility_outlined,
                         color: settingProvider.themMode == ThemeMode.light
                    ? AppTheme.darktItem
                    : AppTheme.white,
                      ),
              )
            : null,
      ),
      maxLines: widget.maxLines,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: isObscure,
    );
  }
}
