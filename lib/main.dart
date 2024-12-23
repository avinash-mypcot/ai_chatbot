import 'package:ai_chatbot/feature/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'feature/chat/presentation/bloc/chat_bloc.dart';
import 'feature/chat/presentation/pages/chat_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initDependency();
  runApp(BlocProvider(
    create: (context) => serviceLocator<ChatBloc>(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const ChatPage(),
          );
        });
  }
}
