import 'package:flutter/material.dart';

import '../../../app/models/chat_user.dart';
import 'chat_view.dart';

class ChatListViewState extends State<ChatListView> {
final TextEditingController _searchController = TextEditingController();
bool _isSearching = false;

final List<ChatUser> _chats = [
  ChatUser(
    id: '1',
    name: 'María González',
    lastMessage: '¿Ya llegó mi pedido? 🍕',
    time: '10:30',
    unreadCount: 2,
    isOnline: true,
  ),
  ChatUser(
    id: '2',
    name: 'Carlos Ruiz',
    lastMessage: 'Gracias por la entrega rápida',
    time: '09:45',
    unreadCount: 0,
    isOnline: false,
  ),
  ChatUser(
    id: '3',
    name: 'Ana Martín',
    lastMessage: 'El repartidor está en camino',
    time: '09:15',
    unreadCount: 1,
    isOnline: true,
  ),
  ChatUser(
    id: '4',
    name: 'José López',
    lastMessage: '¿Tienen promociones hoy?',
    time: 'Ayer',
    unreadCount: 0,
    isOnline: false,
  ),
  ChatUser(
    id: '5',
    name: 'Lucía Torres',
    lastMessage: 'Perfecto, nos vemos mañana',
    time: 'Ayer',
    unreadCount: 0,
    isOnline: true,
  ),
  ChatUser(
    id: '6',
    name: 'Soporte Técnico',
    lastMessage: 'Tu problema ha sido resuelto',
    time: '2 días',
    unreadCount: 0,
    isOnline: false,
  ),
];

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: _buildAppBar(),
    body: Column(
      children: [
        if (_isSearching) _buildSearchBar(),
        Expanded(child: _buildChatList()),
      ],
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {},
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      child: const Icon(Icons.chat),
    ),
  );
}

PreferredSizeWidget _buildAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0.5,
    title: const Text(
      'Chats',
      style: TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
    actions: [
      IconButton(
        icon: Icon(
          _isSearching ? Icons.close : Icons.search,
          color: Colors.black,
        ),
        onPressed: () {
          setState(() {
            _isSearching = !_isSearching;
            if (!_isSearching) {
              _searchController.clear();
            }
          });
        },
      ),
      IconButton(
        icon: const Icon(Icons.more_vert, color: Colors.black),
        onPressed: () {},
      ),
    ],
  );
}

Widget _buildSearchBar() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
        bottom: BorderSide(color: Colors.grey[200]!),
      ),
    ),
    child: TextField(
      controller: _searchController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Buscar chats...',
        hintStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
      ),
    ),
  );
}

Widget _buildChatList() {
  return ListView.builder(
    itemCount: _chats.length,
    itemBuilder: (context, index) {
      final chat = _chats[index];
      return _buildChatTile(chat);
    },
  );
}

Widget _buildChatTile(ChatUser chat) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatDetailView(user: chat),
        ),
      );
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[100]!),
        ),
      ),
      child: Row(
        children: [
          // Avatar
          Stack(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.grey[200],
                child: Text(
                  chat.name[0].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              if (chat.isOnline)
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),

          // Contenido del chat
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      chat.name,
                      style: TextStyle(
                        fontWeight: chat.unreadCount > 0
                            ? FontWeight.bold
                            : FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      chat.time,
                      style: TextStyle(
                        color: chat.unreadCount > 0
                            ? Colors.black
                            : Colors.grey[600],
                        fontSize: 12,
                        fontWeight: chat.unreadCount > 0
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        chat.lastMessage,
                        style: TextStyle(
                          color: chat.unreadCount > 0
                              ? Colors.black
                              : Colors.grey[600],
                          fontSize: 14,
                          fontWeight: chat.unreadCount > 0
                              ? FontWeight.w500
                              : FontWeight.normal,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (chat.unreadCount > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          chat.unreadCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}
