import 'package:flutter/material.dart';
import 'package:maple_byte/Utils/app_colors.dart';

class RoundButton extends StatefulWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;
  final Color foregroundColor;
  final FocusNode? focusNode;
  final String? fontFamily;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double fontSize;
  const RoundButton({
    super.key,
    required this.title,
    required this.onPress,
    this.loading = false,
    this.foregroundColor = AppColors.whiteColor,
    this.focusNode,
    this.fontFamily,
    this.borderRadius = 10.0,
    this.fontSize = 25,
    this.padding = const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
  });

  @override
  State<RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  @override
  Widget build(BuildContext context) {
    return widget.loading
        ? const CircularProgressIndicator(color: AppColors.darkBlueColor)
        : Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              gradient: LinearGradient(
                begin: Alignment(-1.0, -20),
                end: Alignment(1.0, 0),
                colors: [Colors.lightBlue, AppColors.darkBlueColor],
              ),
            ),
            child: ElevatedButton(
              focusNode: widget.focusNode,
              onPressed: widget.onPress,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
              ),
              child: Padding(
                padding: widget.padding,
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: widget.fontSize,

                    fontFamily: widget.fontFamily ?? 'Inter',
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
          );
  }
}
