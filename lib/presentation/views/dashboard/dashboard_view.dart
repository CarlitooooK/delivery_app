import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/dashboard_viewmodel.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    // Consumer widget listens for changes in DashboardViewModel.
    // When notifyListeners() is called in the view model, this widget rebuilds.
    return Consumer<DashboardViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          // The body of the scaffold is set to the current view from the view model.
          body: viewModel.currentView,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),child: BottomNavigationBar(
            currentIndex: viewModel.currentIndex,
            onTap: viewModel.onTabTapped,
            // Method reference to handle tap events.
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_rounded),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_rounded),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map_rounded),
                label: 'Tracking',
              ),
            ],
            selectedItemColor: Colors.black,
            backgroundColor: Colors.white,
            selectedFontSize: 18,
            iconSize: 28,
            showUnselectedLabels: false,
            unselectedItemColor: Colors.black,
          ),
        ));
      },
    );
  }
}
