import 'package:ai_chatbot/feature/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/router/app_router.dart';
import 'feature/auth/signin/presentation/bloc/signin_bloc.dart';
import 'feature/auth/signup/presentation/bloc/signup_bloc.dart';
import 'feature/chat/presentation/bloc/chat_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'feature/history/presentation/bloc/history_bloc.dart';
import 'feature/profile/presentation/bloc/profile_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initDependency();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => serviceLocator<ChatBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<HistoryBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<ProfileBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<SignUpBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<SigninBloc>(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: _appRouter.config(),
          );
        });
  }
}
