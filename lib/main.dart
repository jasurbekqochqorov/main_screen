import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:main_screen/screens/tab_box.dart';
import 'package:main_screen/services/book_manager_services.dart';

import 'bloc/book_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FileManagerService.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BookBloc()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 800),
        builder: (context, child) {
          ScreenUtil.init(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(useMaterial3: false),
            home: child,
          );
        },
        child: const TabBox1(),
      ),
    );
  }
}
