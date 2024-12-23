import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import '../theme/app_colors.dart';

class AppUtils{

  static InterceptorsWrapper getLoggingInterceptor() {
    int count = 0;
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        count++;

        debugPrint(
            '${AppColors.cyan}Request[${options.method}] => PATH: ${options.path}$reset');
        debugPrint(
            '${AppColors.white}Request HEADERS: ${options.headers}$reset');
        debugPrint('${AppColors.yellow}Request DATA: ${options.data}$reset');
        debugPrint('${AppColors.magenta}API call count: $count');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint(
            '${AppColors.green}Response[${response.statusCode}] => DATA: ${response.data}$reset');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        debugPrint("test error:}");
        debugPrint(
            '${AppColors.red}Error[${e.response?.statusCode}] => MESSAGE: ${e.message}$reset');
        debugPrint('${AppColors.red}Error DATA: ${e.response?.data}$reset');
        return handler.next(e);
      },
    );
  }

}