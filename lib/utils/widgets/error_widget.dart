import 'package:flutter/material.dart';

Widget errorWidget(Size size, BuildContext context) {
  return SizedBox(
    width: size.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.error_outline,
          size: 35,
        ),
        const SizedBox(
          height: 20,
        ),
        Text("Error in data loading",
            style: Theme.of(context).textTheme.headlineSmall),
      ],
    ),
  );
}
