import 'package:ai_chatbot/feature/chat/data/api/chat_api.dart';
import 'package:ai_chatbot/feature/chat/data/repository/chat_repository.dart';
import 'package:ai_chatbot/feature/chat/data/services/chat_services.dart';
import 'package:ai_chatbot/feature/chat/presentation/bloc/chat_bloc.dart';
import 'package:ai_chatbot/feature/history/data/api/history_api.dart';
import 'package:ai_chatbot/feature/history/data/repository/history_repository.dart';
import 'package:ai_chatbot/feature/history/data/services/history_services.dart';
import 'package:ai_chatbot/feature/history/presentation/bloc/history_bloc.dart';
import 'package:ai_chatbot/feature/profile/data/api/profile_api.dart';
import 'package:ai_chatbot/feature/profile/data/repository/profile_repository.dart';
import 'package:ai_chatbot/feature/profile/data/services/profile_services.dart';
import 'package:ai_chatbot/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'auth/signup/presentation/bloc/signup_bloc.dart';
part 'init_dependencies_main.dart';
