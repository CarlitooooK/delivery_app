import 'package:delivery_app/presentation/viewmodels/dashboard_viewmodel.dart';
import 'package:delivery_app/presentation/views/dashboard/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: ChangeNotifierProvider(create:
      (context)=> DashboardViewModel(),
      child: const DashboardView())
    );
  }
}

