import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Function(String text) onValidate;
  final Function(String text) onSave;
  final String label;
  final bool isObscure;
  final TextInputType keyboardType;
  final IconData icon;
  CustomTextField(
      {@required this.label,
      @required this.onSave,
      @required this.onValidate,
      this.isObscure,
      this.keyboardType,
      this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.3,
      child: TextFormField(
        keyboardType: keyboardType,
        onSaved: onSave,
        obscureText: isObscure,
        validator: onValidate,
        cursorColor: Theme.of(context).colorScheme.secondary,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
          prefixIcon: Icon(
            icon,
            color: Theme.of(context).colorScheme.secondary,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                width: 0.5, color: Theme.of(context).colorScheme.secondary),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                width: 0.5, color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 16, color: Theme.of(context).colorScheme.onBackground),
      ),
    );
  }
}
