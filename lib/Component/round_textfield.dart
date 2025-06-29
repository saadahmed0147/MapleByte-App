import 'package:flutter/material.dart';
import 'package:maple_byte/Utils/app_colors.dart';

class RoundTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final TextInputType inputType;
  final FocusNode? focusNode;
  final IconData? prefixIcon;
  final void Function(String)? onFieldSubmitted;
  final bool? isPasswordField;
  final TextEditingController textEditingController;
  final String? validatorValue;
  final Function(String)? onChange;
  final double? borderRadius;
  final Color? bgColor;
  final Color? errorBorderColor;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;

  const RoundTextField({
    super.key,
    required this.label,
    this.hint,
    required this.inputType,
    this.prefixIcon,
    required this.textEditingController,
    this.isPasswordField,
    this.onFieldSubmitted,
    this.focusNode,
    this.validatorValue,
    this.onChange,
    this.borderRadius,
    this.bgColor,
    this.errorBorderColor,
    this.focusedBorderColor,
    this.enabledBorderColor,
  });

  @override
  State<RoundTextField> createState() => _RoundTextFieldState();
}

class _RoundTextFieldState extends State<RoundTextField> {
  ValueNotifier<bool> passwordVisiblity = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ValueListenableBuilder(
        valueListenable: passwordVisiblity,
        builder: (context, value, child) {
          return TextFormField(
            onChanged: widget.onChange,
            validator: (value) {
              if (value!.isEmpty) {
                return widget.validatorValue;
              }
              return null;
            },
            onFieldSubmitted: widget.onFieldSubmitted,
            controller: widget.textEditingController,
            keyboardType: widget.inputType,
            focusNode: widget.focusNode,
            obscureText:
                widget.isPasswordField == true && passwordVisiblity.value,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: widget.bgColor ?? AppColors.whiteColor,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: widget.hint,
              hintStyle: const TextStyle(color: Color(0xff8eaa8e)),
              prefixIcon: widget.prefixIcon != null
                  ? Icon(widget.prefixIcon)
                  : null,

              suffixIcon: widget.isPasswordField == true
                  ? IconButton(
                      onPressed: () {
                        passwordVisiblity.value = !passwordVisiblity.value;
                      },
                      icon: Icon(
                        passwordVisiblity.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    )
                  : null,

              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.errorBorderColor ?? AppColors.greyColor,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius ?? 16.0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.focusedBorderColor ?? AppColors.darkBlueColor,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius ?? 16.0),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.enabledBorderColor ?? AppColors.greyColor,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius ?? 16.0),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
