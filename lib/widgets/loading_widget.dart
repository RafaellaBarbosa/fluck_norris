import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, required this.labelLoading});

  final String labelLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20,
      children: [
        Center(
          child: Image.asset('assets/chuck_norris_logo.png', width: 250),
        ),
        CircularProgressIndicator(color: Colors.orange),
        Text(
          labelLoading,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }
}
