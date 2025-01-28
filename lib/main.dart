import 'package:ai_chatbot/feature/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_widget/home_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/router/app_router.dart';
import 'feature/auth/signin/presentation/bloc/signin_bloc.dart';
import 'feature/auth/signup/presentation/bloc/signup_bloc.dart';
import 'feature/chat/presentation/bloc/chat_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'feature/chat/presentation/bloc/upload_image_bloc/upload_image_bloc.dart';
import 'feature/history/presentation/bloc/history_bloc.dart';
import 'feature/profile/presentation/bloc/profile_bloc.dart';
import 'firebase_options.dart';
// import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await HomeWidget.setAppGroupId('group.es.antonborri.homeWidgetCounter');
  await Supabase.initialize(
    url: "https://xxiqqggvruviwczcsxpt.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh4aXFxZ2d2cnV2aXdjemNzeHB0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzgwNDczNDYsImV4cCI6MjA1MzYyMzM0Nn0.qr6dOhtZKbseyID9unRHK80D01ZqrSSD4PvSQesNn2c",
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
      BlocProvider(
        create: (context) => serviceLocator<UploadImageBloc>(),
      ),
    ],
    child: MyApp(),
  ));
}

/// Callback invoked by HomeWidget Plugin when performing interactive actions
/// The @pragma('vm:entry-point') Notification is required so that the Plugin can find it
// @pragma('vm:entry-point')
// Future<void> interactiveCallback(Uri? uri) async {
//   // Set AppGroup Id. This is needed for iOS Apps to talk to their WidgetExtensions
//   await HomeWidget.setAppGroupId('group.es.antonborri.homeWidgetCounter');

//   // We check the host of the uri to determine which action should be triggered.
//   if (uri?.host == 'increment') {
//     // await _increment(){};
//   } else if (uri?.host == 'clear') {
//     // await _clear();
//   }
// }

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
