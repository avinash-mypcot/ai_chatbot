part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependency() async {
  serviceLocator.registerLazySingleton(() => Dio());
  _initChat();
  _initHistory();
}

_initHistory() {
  serviceLocator
    ..registerLazySingleton(() => HistoryApi())
    ..registerLazySingleton(
        () => HistoryServices(api: serviceLocator(), dio: serviceLocator()))
    ..registerLazySingleton(() => HistoryRepository(service: serviceLocator()))
    ..registerLazySingleton(() => HistoryBloc(repository: serviceLocator()));
}

_initChat() {
  serviceLocator
    //Api
    ..registerLazySingleton(() => ChatApi(serviceLocator()))
    //Services
    ..registerLazySingleton(
        () => ChatServices(api: serviceLocator(), dio: serviceLocator()))
    //Repository
    ..registerFactory(() => HomeRepository(service: serviceLocator()))
    //Bloc
    ..registerLazySingleton(() => ChatBloc(repository: serviceLocator()));
}
