import 'package:delivery_app/presentation/views/deliveries/map_view.dart';
import 'package:delivery_app/presentation/views/orders/orders_list.dart';
import 'package:flutter/material.dart';

import '../views/dashboard/home_view.dart';
import '../views/deliveries/chat_view.dart';


class DashboardViewModel extends ChangeNotifier {
  int _currentIndex = 0;

  final List<Widget> _views = [
    const HomeView(),
    const OrdersList(),
    const ChatMainView(),
    new MapView(),
  ];

  int get currentIndex => _currentIndex;

  Widget get currentView => _views[_currentIndex];

  void onTabTapped(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
      notifyListeners();
    }
  }
}

