import 'package:flutter/material.dart';

class TextFieldCustom extends StatefulWidget {
  const TextFieldCustom(
      {super.key,
      required this.hint,
      required this.label,
      required this.icon,
      this.isPassword = false,
      this.controller,
      this.onChanged,
      this.obscureText = false,
      this.minLines = 1,
      this.maxLines = 1});

     

  final String hint;
  final String label;
  final IconData icon;
  final bool? isPassword;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final bool obscureText;
  final int minLines;
  final int maxLines;

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
    bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        enabled: true,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        controller: widget.controller,
        onChanged: widget.onChanged,
  obscureText: widget.isPassword! ? obscurePassword : false,    obscuringCharacter: "*",
        cursorColor: Colors.red,
        cursorWidth: 10,
        decoration: InputDecoration(
            fillColor: Colors.grey,
            filled: true,
            hintText: widget.hint,
            labelText: widget.label,
            prefixIcon: Icon(
              widget.icon,
              color: Colors.white,
            ),
            suffixIcon: widget.isPassword!
              ? IconButton(
                  icon: Icon(
                    obscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                )
              : null,
                   
            labelStyle: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            border: const OutlineInputBorder(
               borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            disabledBorder: const OutlineInputBorder(
           
                borderSide: BorderSide(color: Colors.blue)
                
                
                ),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.cyanAccent))),
      ),
    );
  }
}
