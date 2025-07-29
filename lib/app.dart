import 'package:goto/constants/exports.dart';
import 'package:goto/views/intial-view.dart';
import 'package:sizer/sizer.dart';

class GoToApp extends StatefulWidget {
  const GoToApp({super.key});

  @override
  State<GoToApp> createState() => _GoToAppState();
}

class _GoToAppState extends State<GoToApp> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizerUtil.setScreenSize(constraints, orientation);

            return Sizer(
              builder: (context, orientation, screenType) {
                return GetMaterialApp(
                  title: Constants.appName,
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.lightTheme,
                  builder: (context, child) {
                    return MediaQuery(
                      data: MediaQuery.of(
                        context,
                      ).copyWith(textScaleFactor: 1.0),
                      child: child!,
                    );
                  },
                  home: SplashView(),
                );
              },
            );
          },
        );
      },
    );
  }
}
