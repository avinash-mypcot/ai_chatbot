// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ai_chatbot/feature/chat/presentation/pages/chat_page.dart'
    as _i1;
import 'package:ai_chatbot/feature/history/presentation/pages/history_page.dart'
    as _i2;
import 'package:auto_route/auto_route.dart' as _i3;

/// generated route for
/// [_i1.ChatPage]
class ChatRoute extends _i3.PageRouteInfo<void> {
  const ChatRoute({List<_i3.PageRouteInfo>? children})
      : super(
          ChatRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.ChatPage();
    },
  );
}

/// generated route for
/// [_i2.HistoryPage]
class HistoryRoute extends _i3.PageRouteInfo<void> {
  const HistoryRoute({List<_i3.PageRouteInfo>? children})
      : super(
          HistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'HistoryRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.HistoryPage();
    },
  );
}
