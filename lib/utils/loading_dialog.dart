import 'package:flutter/material.dart';

void buildLoadingDialog({
  required BuildContext context,
  String title = "Loading...",
}) {
  showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.black),
                ),
                const SizedBox(
                  height: 8,
                ),
                const CircularProgressIndicator.adaptive(),
              ],
            ),
          ),
        );
      });
}
