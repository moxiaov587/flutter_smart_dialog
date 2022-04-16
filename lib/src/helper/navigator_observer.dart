import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/src/data/smart_tag.dart';
import 'package:flutter_smart_dialog/src/helper/route_record.dart';

import '../config/enum_config.dart';
import '../smart_dialog.dart';
import 'dialog_proxy.dart';

class SmartNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    DialogProxy.contextNavigator ??= navigator?.context;
    RouteRecord.instance.push(route, previousRoute);
    RouteRecord.curRoute = route;
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {}

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {}

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) async {
    RouteRecord.instance.pop(route, previousRoute);
    RouteRecord.curRoute = previousRoute;

    if (!SmartDialog.config.isExist ||
        route.settings.name == SmartTag.systemDialog) return;

    //smart close dialog
    var dialogQueue = DialogProxy.instance.dialogQueue;
    for (var i = dialogQueue.length; i > 0; i--) {
      if (dialogQueue.isEmpty || dialogQueue.last.useSystem) return;

      // await DialogProxy.instance.dismiss(status: SmartStatus.dialog);
    }
  }
}
