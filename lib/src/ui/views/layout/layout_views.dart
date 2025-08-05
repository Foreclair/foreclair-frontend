import 'package:flutter/material.dart';

class LayoutViews extends StatefulWidget {
  const LayoutViews({super.key});

  @override
  State<LayoutViews> createState() => _LayoutViewsState();
}

class _LayoutViewsState extends State<LayoutViews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: const Key('layoutScaffold'));
  }
}
