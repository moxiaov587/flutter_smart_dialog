import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_smart_dialog/src/helper/dialog_proxy.dart';

import '../data/animation_param.dart';
import '../data/base_dialog.dart';
import '../widget/helper/smart_overlay_entry.dart';

class CustomLoading extends BaseDialog {
  CustomLoading({required SmartOverlayEntry overlayEntry}) : super(overlayEntry);

  Timer? _timer;
  Timer? _displayTimer;
  bool _canDismiss = false;
  Future Function()? _canDismissCallback;

  Future<T?> showLoading<T>({
    required Widget widget,
    required AlignmentGeometry alignment,
    required bool clickMaskDismiss,
    required SmartAnimationType animationType,
    required List<SmartNonAnimationType> nonAnimationTypes,
    required AnimationBuilder? animationBuilder,
    required bool usePenetrate,
    required bool useAnimation,
    required Duration animationTime,
    required Color maskColor,
    required Widget? maskWidget,
    required VoidCallback? onDismiss,
    required VoidCallback? onMask,
    required Duration? displayTime,
    required bool backDismiss,
  }) {
    DialogProxy.instance.loadingBackDismiss = backDismiss;
    SmartDialog.config.loading.isExist = true;

    _canDismiss = false;
    _canDismissCallback = null;
    _timer?.cancel();
    _timer = Timer(SmartDialog.config.loading.leastLoadingTime, () {
      _canDismiss = true;
      _canDismissCallback?.call();
    });

    return mainDialog.show<T>(
      widget: widget,
      animationType: animationType,
      nonAnimationTypes: nonAnimationTypes,
      animationBuilder: animationBuilder,
      alignment: alignment,
      maskColor: maskColor,
      maskWidget: maskWidget,
      usePenetrate: usePenetrate,
      useAnimation: useAnimation,
      animationTime: animationTime,
      onDismiss: _handleDismiss(onDismiss, displayTime),
      useSystem: false,
      reuse: true,
      awaitOverType: SmartDialog.config.loading.awaitOverType,
      maskTriggerType: SmartDialog.config.loading.maskTriggerType,
      ignoreArea: null,
      onMask: () {
        onMask?.call();
        if (!clickMaskDismiss) return;
        _realDismiss();
      },
    );
  }

  VoidCallback _handleDismiss(VoidCallback? onDismiss, Duration? displayTime) {
    _displayTimer?.cancel();
    if (displayTime != null) {
      _displayTimer = Timer(displayTime, () => dismiss());
    }

    return () {
      _displayTimer?.cancel();
      onDismiss?.call();
    };
  }

  Future<void> _realDismiss({CloseType closeType = CloseType.normal}) async {
    if (!DialogProxy.instance.loadingBackDismiss && closeType == CloseType.back) {
      return null;
    }

    await mainDialog.dismiss(closeType: closeType);
    SmartDialog.config.loading.isExist = false;
  }

  Future<void> dismiss({CloseType closeType = CloseType.normal}) async {
    _canDismissCallback = () => _realDismiss(closeType: closeType);
    if (_canDismiss) await _canDismissCallback?.call();
  }
}
