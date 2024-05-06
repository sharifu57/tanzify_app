import 'package:flutter/material.dart';
import 'package:tanzify_app/pages/constants.dart';

enum FormButtonVariant { filled, flat, outlined }

class FormButton extends StatelessWidget {
  final bool loading;
  final bool small;
  final bool disabled;
  final FormButtonVariant variant;
  final VoidCallback onClick;
  final String text;
  final bool fullWidth;

  const FormButton({
    super.key,
    this.loading = false,
    this.small = false,
    this.disabled = false,
    required this.variant,
    required this.onClick,
    required this.text,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle textStyle = theme.textTheme.button!.copyWith(
      color: disabled ? Colors.grey : Colors.white,
    );

    Widget buttonChild = loading
        ? const CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        : Text(text, style: textStyle);

    return SizedBox(
      width: fullWidth ? double.infinity : null, // Set width based on fullWidth
      // height: 100,
      child: ElevatedButton(
        onPressed: disabled ? null : onClick,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) return Colors.grey;
              if (variant == FormButtonVariant.filled)
                return Constants.primaryColor;
              // return theme.primaryColor;
              return Colors.transparent; // Default for flat and outlined
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (variant == FormButtonVariant.outlined &&
                  !states.contains(MaterialState.disabled)) {
                return theme.primaryColor;
              }
              return null; // Use default
            },
          ),
          side: variant == FormButtonVariant.outlined
              ? MaterialStateProperty.all(BorderSide(color: theme.primaryColor))
              : null,
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
                vertical: small ? 8 : 16, horizontal: small ? 12 : 24),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
          child: buttonChild,
        ),
      ),
    );
  }
}
