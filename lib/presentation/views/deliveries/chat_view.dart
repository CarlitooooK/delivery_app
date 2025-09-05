import 'package:flutter/material.dart';
import '../../../app/models/chat_user.dart';
import 'chat_detail_view_state.dart';
import 'chat_list_view_state.dart';

class ChatListView extends StatefulWidget {
  const ChatListView({super.key});

  @override
  State<ChatListView> createState() => ChatListViewState();
}


class ChatDetailView extends StatefulWidget {
  final ChatUser user;

  const ChatDetailView({super.key, required this.user});

  @override
  State<ChatDetailView> createState() => ChatDetailViewState();
}


class ChatMainView extends StatelessWidget {
  const ChatMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChatListView();
  }
}