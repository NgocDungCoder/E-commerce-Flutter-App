import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final Color? color;
  final double? letterSpacing;
  final bool? softWrap;

  const PrimaryText(
    String this.text, {
    super.key,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w400,
    this.color = Colors.black,
    this.textAlign = TextAlign.left,
    this.letterSpacing = 1,
    this.softWrap,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      softWrap: softWrap,
      style: GoogleFonts.lato(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: 1.5,
        // Khoảng cách dòng
        letterSpacing: letterSpacing,
      ),
    );
  }
}
