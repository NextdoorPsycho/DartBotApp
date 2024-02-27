import 'package:fast_log/fast_log.dart';
import 'package:flutter/material.dart';
import 'package:shit_ui_app/main.dart';
import 'package:toastification/toastification.dart';

genericNotification(BuildContext context, String topText, String bottomText) {
  info("Generic Notification - ${topText}");
  ColorScheme colorScheme = Theme.of(context).colorScheme;
  return toastification.show(
    context: context,
    backgroundColor: colorScheme.surface,
    type: ToastificationType.success,
    foregroundColor: colorScheme.onSurface,
    style: ToastificationStyle.minimal,
    title: Text(
      topText,
      style: myTextStyle(context, title: true),
    ),
    description: Text(
      bottomText,
      style: myTextStyle(context),
    ),
    alignment: Alignment.topCenter,
    autoCloseDuration: const Duration(seconds: 3),
    primaryColor: colorScheme.primary,
    icon: Icon(Icons.keyboard_arrow_right_sharp, color: colorScheme.onSurface),
    borderRadius: BorderRadius.circular(1.0),
    boxShadow: lowModeShadow,
    dragToClose: true,
    closeOnClick: true,
    closeButtonShowType: CloseButtonShowType.always,
    pauseOnHover: true,
    applyBlurEffect: false,
  );
}

errorGeneric(BuildContext context, String topText, String bottomText,
    {int time = 3}) {
  error("Generic Error - $topText");
  return toastification.show(
    context: context,
    type: ToastificationType.error,
    style: ToastificationStyle.flatColored,
    title: Text(topText),
    description: Text(bottomText),
    alignment: Alignment.topCenter,
    autoCloseDuration: Duration(seconds: time),
    animationBuilder: (
      context,
      animation,
      alignment,
      child,
    ) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    icon: const Icon(
      Icons.error_outline_sharp,
    ),
    borderRadius: BorderRadius.circular(4.0),
    boxShadow: highModeShadow,
    showProgressBar: true,
    dragToClose: true,
    applyBlurEffect: true,
  );
}
