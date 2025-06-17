import 'package:flutter/material.dart';
import 'package:nextgen_reeftech/features/home/presentation/provider/home_vm.dart';
import 'package:nextgen_reeftech/features/modes/presentation/provider/mode_vm.dart';

import 'package:provider/provider.dart';

import 'features/landing/provider/onboard_vm.dart';
import 'features/user/presentation/provider/auth_vm.dart';

class Injector extends StatelessWidget {
  final Widget routerWidget;
  Injector({super.key, required this.routerWidget});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthVM()),
        ChangeNotifierProvider(create: (context) => ModeVM()),





        ChangeNotifierProvider(create: (context) => HomeVM()),
        ChangeNotifierProvider(create: (context) => OnboardVm()),
      ],
      child: routerWidget,
    );
  }
}
