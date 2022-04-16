import 'package:flutter/material.dart';

import 'enum_config.dart';

///showToast() global config
///
///showToast() 全局配置
class SmartConfigToast {
  SmartConfigToast({
    this.alignment = Alignment.center,
    this.animationType = SmartAnimationType.fade,
    this.animationTime = const Duration(milliseconds: 200),
    this.useAnimation = true,
    this.usePenetrate = true,
    this.maskColor = const Color.fromRGBO(0, 0, 0, 0.35),
    this.maskWidget,
    this.clickMaskDismiss = false,
    this.debounce = false,
    this.debounceTime = const Duration(milliseconds: 300),
    this.displayType = SmartToastType.normal,
    this.consumeEvent = false,
    this.displayTime = const Duration(milliseconds: 2000),
    this.intervalTime = const Duration(milliseconds: 150),
    this.isExist = false,
  });

  /// control the location of the dialog on the screen
  ///
  /// center: the dialog locate the center on the screen，The animation type can be set using [animationType]
  ///
  /// bottomCenter、bottomLeft、bottomRight：the dialog locate the bottom on the screen，
  /// animation effect is bottom-to-up
  ///
  /// topCenter、topLeft、Alignment.topRight：the dialog locate the top on the screen，
  /// animation effect is up-to-bottom
  ///
  /// centerLeft：the dialog locate the left on the screen，animation effect is left-to-right
  ///
  /// centerRight：the dialog locate the right on the screen，animation effect is right-to-left
  ///
  /// -------------------------------------------------------------------------------
  ///
  /// 控制dialog位于屏幕的位置
  ///
  /// center: dialog位于屏幕中间，可使用[animationType]设置动画类型
  ///
  /// bottomCenter、bottomLeft、bottomRight：dialog位于屏幕底部，动画默认为位移动画，自下而上
  ///
  /// topCenter、topLeft、Alignment.topRight：dialog位于屏幕顶部，
  ///
  /// centerLeft：dialog位于屏幕左边，动画默认为位移动画，自左而右，
  ///
  /// centerRight：dialog位于屏幕左边，动画默认为位移动画，自右而左，
  final AlignmentGeometry alignment;

  /// [animationTime]：The animation time can be set
  ///
  /// [animationTime]：可设置动画时间
  final Duration animationTime;

  /// Animation type [animationType]：For details, please refer to the [SmartAnimationType] comment
  ///
  /// 动画类型[animationType]： 具体可参照[SmartAnimationType]注释
  final SmartAnimationType animationType;

  /// default（true），true（use the animation），false（not use）
  ///
  /// 是否使用动画（默认：true）
  final bool useAnimation;

  /// default（false），true（click event will penetrate background），false（not penetration）
  ///
  /// 屏幕上交互事件可以穿透遮罩背景（默认:false）：true（交互事件能穿透背景，遮罩会自动变成透明），false（不能穿透）
  final bool usePenetrate;

  /// the color of the mask，it is invalid if [usePenetrate] is true or [maskWidget] set the value
  ///
  /// 遮罩颜色：[usePenetrate]设置为true或[maskWidget]参数设置了数据，该参数会失效
  final Color maskColor;

  /// highly customizable mask, it is invalid if [usePenetrate] is true
  ///
  /// 遮罩Widget，可高度自定义你自己的遮罩背景：[usePenetrate]设置为true，该参数失效
  final Widget? maskWidget;

  /// default（true），true（loading will be closed after click background），false（not close）
  ///
  /// 点击遮罩，是否关闭dialog（默认：true）：true（点击遮罩关闭dialog），false（不关闭）
  final bool clickMaskDismiss;

  /// debounce feature，it works on toast and dialog：default（false）;
  ///
  /// 防抖功能，它作用于toast和dialog上：默认（false）;
  final bool debounce;

  /// [debounceTime]：Within the debounce time, multiple clicks will only respond to the first time,
  /// and the second invalid click will trigger the debounce time to re-time.
  ///
  /// [debounceTime]：防抖时间内，多次点击只会响应第一次，第二次无效点击会触发防抖时间重新计时
  final Duration debounceTime;

  /// provider multiple display logic，please refer to [SmartToastType] comment for detailed description
  ///
  /// 提供多种显示逻辑，详细描述请查看 [SmartToastType] 注释
  final SmartToastType displayType;

  /// true (toast will consume touch events), false (toast no longer consumes events, touch events can penetrate toast)
  ///
  /// true（toast会消耗触摸事件），false（toast不再消耗事件，触摸事件能穿透toast）
  final bool consumeEvent;

  /// toast display time on the screen
  ///
  /// toast在屏幕上的显示时间
  final Duration displayTime;

  /// Multiple toasts are displayed continuously, and the interval time between each toast is displayed
  ///
  /// 多个toast连续显示,每个toast之间显示的间隔时间
  final Duration intervalTime;

  /// whether toast(showToast()) exist on the screen
  ///
  /// toast(showToast())是否存在在界面上
  bool isExist;
}
