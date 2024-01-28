import 'package:flutter/material.dart';

class CustomRichText extends StatefulWidget {
  final String title;
  final String subtitle;
  const CustomRichText({super.key, required this.title, required this.subtitle});

  @override
  State<CustomRichText> createState() => _CustomRichTextState();
}

class _CustomRichTextState extends State<CustomRichText> {
  @override
  Widget build(BuildContext context) {
    return RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  text: "${widget.title}: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Customize the color as needed
                    fontSize: 29.00,
                  ),
                ),
                
                TextSpan(
                  text: '${widget.subtitle}',
                  style: TextStyle(
                    fontSize: 29.0, // Customize the font size as needed
                    color: Colors.black54, // Customize the color as needed
                    
                  ),
                ),
              ],
            ),
          );
  }
}