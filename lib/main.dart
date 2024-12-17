import 'package:flutter/material.dart';

import 'features/pets/screens/pets_list.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Pet Shop",
      debugShowCheckedModeBanner: false,
      home: PetsList(),
    );
  }
}
