import 'package:flutter/material.dart';

class ScrollableScaffold extends StatelessWidget {
  final String name;
  final double padding;
  final Alignment alignment;
  final Widget child;

  const ScrollableScaffold({
    Key? key,
    required this.name,
    this.padding = 10,
    this.alignment = Alignment.center,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Container(
        padding: EdgeInsets.all(padding),
        alignment: alignment,
        child: SingleChildScrollView(
          child: child,
        ),
      ),
    );
  }
}
