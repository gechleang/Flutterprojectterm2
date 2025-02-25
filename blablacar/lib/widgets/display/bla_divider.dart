
import 'package:blablacar/theme/theme.dart';
import 'package:flutter/material.dart';

class BlaDivider extends StatelessWidget {
  const BlaDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: BlaColors.greyLight,
    );
  }
}
