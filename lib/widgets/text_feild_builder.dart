import 'package:flutter/material.dart';

class TextFieldBuilder extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final bool isEmail;
  final bool isPassword;
  final Function validator;
  final Function onChanged;
  final Function onSaved;
  final TextEditingController controller;

  const TextFieldBuilder(
      {Key key,
      this.labelText,
      this.prefixIcon,
      this.suffixIcon,
      this.isEmail = false,
      this.isPassword = false,
      this.controller,
      this.validator,
      this.onChanged,
      this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: InputDecoration(
              labelText: labelText,
              prefixIcon:
                  this.prefixIcon != null ? Icon(this.prefixIcon) : null,
              suffix: this.suffixIcon != null ? Icon(this.suffixIcon) : null,
              contentPadding: EdgeInsets.symmetric(vertical: 0.0)),
          obscureText: isPassword ? true : false,
          keyboardType:
              isEmail ? TextInputType.emailAddress : TextInputType.text,
          validator: validator,
          controller: controller,
          onChanged: onChanged,
          onSaved: onSaved,
        ));
  }
}
