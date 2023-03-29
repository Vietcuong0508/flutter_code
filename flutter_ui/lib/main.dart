import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled/pages/choose_topic.page.dart';
import 'package:untitled/pages/home_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:untitled/utils/theme.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: kColorPrimary,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      initialRoute: '$HomePage',
      routes: {
        '$HomePage': (_) => const HomePage(),
        '$ChooseTopicPage': (_) => const ChooseTopicPage(),
      },
    );
  }
}
