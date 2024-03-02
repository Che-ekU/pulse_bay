import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:pulse_bay_task/app/app_provider.dart';
import 'package:pulse_bay_task/app/constants/theme.dart';
import 'package:pulse_bay_task/app/login.dart';

class PulseBayTask extends StatelessWidget {
  const PulseBayTask({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: PulseBayTheme.primaryFontFamily,
          colorScheme: ColorScheme.fromSeed(
            seedColor: PulseBayTheme.primaryColor,
          ),
          useMaterial3: true,
        ),
        home: const Login(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
