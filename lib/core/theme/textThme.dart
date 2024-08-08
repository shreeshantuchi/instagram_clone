import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextTheme instagramTextTheme = TextTheme(
  // DisplayLarge: For very large titles or key sections, like profile names or main page headings
  displayLarge: TextStyle(
    fontFamily: 'Proxima',
    fontSize: 36.0.sp,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
    color: Colors.black,
  ),

  // DisplayMedium: Slightly smaller than DisplayLarge, for major section titles or prominent headings
  displayMedium: TextStyle(
    fontFamily: 'Proxima',
    fontSize: 30.0.sp,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.1,
    color: Colors.black,
  ),

  // DisplaySmall: For medium-sized titles or important subheadings
  displaySmall: TextStyle(
    fontFamily: 'Proxima',
    fontSize: 24.0.sp,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.1,
    color: Colors.black,
  ),

  // HeadlineLarge: Suitable for key headings in sections like post captions or main profiles
  headlineLarge: TextStyle(
    fontFamily: 'Proxima',
    fontSize: 20.0.sp,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.0,
    color: Colors.black,
  ),

  // HeadlineMedium: For prominent headings or slightly less important titles
  headlineMedium: TextStyle(
    fontFamily: 'Proxima',
    fontSize: 18.0.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.8,
    color: Colors.black,
  ),

  // HeadlineSmall: Smaller headings or subheadings for less prominent sections
  headlineSmall: TextStyle(
    fontFamily: 'Proxima',
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.8,
    color: Colors.black,
  ),

  // TitleLarge: For larger text in buttons, cards, or other key UI elements
  titleLarge: TextStyle(
    fontFamily: 'Proxima',
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w500,
    color: Colors.black54, // Light color for secondary importance
  ),

  // TitleMedium: For titles or subheadings in lists and secondary elements
  titleMedium: TextStyle(
    fontFamily: 'Proxima',
    fontSize: 14.0.sp,
    fontWeight: FontWeight.w500,
    color: Colors.black54,
  ),

  // TitleSmall: For small titles or less prominent text in cards or lists
  titleSmall: TextStyle(
    fontFamily: 'Proxima',
    fontSize: 14.0.sp,
    fontWeight: FontWeight.w500,
    color: Colors.black54,
  ),

  // BodyLarge: Main text style for content-heavy areas, such as post captions or comments
  bodyLarge: TextStyle(
    fontFamily: 'Proxima',
    fontSize: 14.0.sp,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  ),

  // BodyMedium: Alternative to BodyLarge for less prominent body text
  bodyMedium: TextStyle(
    fontFamily: 'Proxima',
    fontSize: 14.0.sp,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
  ),

  // BodySmall: Smaller body text for less important content or detailed information
  bodySmall: TextStyle(
    fontFamily: 'Proxima',
    fontSize: 12.0.sp,
    fontWeight: FontWeight.normal,
    color: Colors.black54,
  ),

  // LabelLarge: For text in buttons, usually bold and white on a colored background
  labelLarge: TextStyle(
    fontFamily: 'Proxima',
    fontSize: 14.0.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white, // Assumes buttons have a colored background
  ),

  // LabelMedium: For labels or tags, often used for smaller elements
  labelMedium: TextStyle(
    fontFamily: 'Proxima',
    fontSize: 12.0.sp,
    fontWeight: FontWeight.normal,
    color: Colors.black54,
  ),

  // LabelSmall: For very small labels or indicators, like timestamps or small badges
  labelSmall: TextStyle(
    fontFamily: 'Proxima',
    fontSize: 10.0.sp,
    fontWeight: FontWeight.normal,
    color: Colors.black54,
  ),
);

TextStyle instagramHeading =
    TextStyle(fontFamily: "Billabong", fontSize: 24.sp);
