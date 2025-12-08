// Automatic FlutterFlow imports
// Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:toastification/toastification.dart';
//NOTE: add this dependencies -> toastification: ^2.3.0

Future<void> customToastification(
  BuildContext context,
  String? toastTitle,
  String toastDescription,
  String toastType,
  String toastStyle,
  String toastPosition,
  bool applyBlurEffect,
) async {
  String titulo = toastTitle ?? "Notification";

  ToastificationType type;
  switch (toastType.toLowerCase()) {
    case 'info':
      type = ToastificationType.info;
      break;
    case 'warning':
      type = ToastificationType.warning;
      break;
    case 'error':
      type = ToastificationType.error;
      break;
    case 'success':
    default:
      type = ToastificationType.success;
      break;
  }

  ToastificationStyle style;
  switch (toastStyle.toLowerCase()) {
    case 'fillcolored':
      style = ToastificationStyle.fillColored;
      break;
    case 'flat':
      style = ToastificationStyle.flat;
      break;
    case 'minimal':
      style = ToastificationStyle.minimal;
      break;
    case 'flatcolored':
    default:
      style = ToastificationStyle.flatColored;
      break;
  }

  Alignment alignment;
  switch (toastPosition) {
    case 'topLeft':
      alignment = Alignment.topLeft;
      break;
    case 'topCenter':
      alignment = Alignment.topCenter;
      break;
    case 'topRight':
      alignment = Alignment.topRight;
      break;
    case 'centerLeft':
      alignment = Alignment.centerLeft;
      break;
    case 'center':
      alignment = Alignment.center;
      break;
    case 'centerRight':
      alignment = Alignment.centerRight;
      break;
    case 'bottomLeft':
      alignment = Alignment.bottomLeft;
      break;
    case 'bottomCenter':
      alignment = Alignment.bottomCenter;
      break;
    case 'bottom-right':
    default:
      alignment = Alignment.bottomRight;
      break;
  }

  toastification.show(
    context: context,
    type: type,
    style: style,
    title: Text(titulo),
    description: Text(toastDescription),
    alignment: alignment, // Usa la posición basada en el parámetro
    autoCloseDuration: const Duration(seconds: 4),
    animationBuilder: (
      context,
      animation,
      alignment,
      child,
    ) {
      return ScaleTransition(
        scale: animation,
        child: child,
      );
    },
    icon: const Icon(Icons.notifications),
    borderRadius: BorderRadius.circular(12.0),
    boxShadow: [
      const BoxShadow(
        color: Colors.black26,
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
    showProgressBar: true,
    dragToClose: true,
    applyBlurEffect: applyBlurEffect,
  );
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
