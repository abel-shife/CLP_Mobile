import 'package:flutter/material.dart';

class ProfileFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isPassword;
  final bool isEditable;


  const ProfileFormField(
      {this.hintText,
      this.validator,
      this.onSaved,
      this.isPassword=false,
      this.isEditable=false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          filled: isEditable?false: true,
          fillColor:isEditable? null: Colors.blueAccent[100],
          prefixIcon: isEditable? Icon(Icons.wrap_text): null
        ),
        obscureText: isPassword? true: false,
        validator: validator,
        onSaved: onSaved,
        enabled: isEditable? true: false,
      ),
    );
  }
}
