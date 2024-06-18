import 'package:flutter/material.dart';
import 'package:tanzify_app/components/dialogs/altertDialog.dart';
import 'package:tanzify_app/pages/constants.dart';

class ClickableContent extends StatelessWidget {
  final Function? onClick;
  final Widget? child;
  final EdgeInsets padding;
  final BoxBorder? border;
  final Color? inkColor;
  const ClickableContent({
    super.key,
    this.child,
    this.inkColor,
    this.onClick = Constants.randoFunction,
    this.padding = EdgeInsets.zero,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    var actualColor = inkColor ?? colorScheme(context).surfaceVariant;

    if (onClick == null) return child ?? Container();

    return Material(
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
          border: border,
        ),
        child: InkWell(
          hoverColor: actualColor,
          focusColor: actualColor,
          highlightColor: actualColor,
          splashColor: actualColor,
          onTap: () {
            try {
              onClick!();
            } catch (e) {
              var offset = (context.findRenderObject() as RenderBox)
                  .localToGlobal(Offset.zero);
              onClick!(offset);
            }
          },
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
