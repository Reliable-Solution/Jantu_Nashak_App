import 'package:flutter/material.dart';

class AlladdressScreen extends StatefulWidget {
  const AlladdressScreen({super.key});

  @override
  State<AlladdressScreen> createState() => _AlladdressScreenState();
}

class _AlladdressScreenState extends State<AlladdressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Address"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Center();
        },
      ),
    );
  }
}
