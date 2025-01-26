import 'package:flutter/material.dart';

class InternetConnectionPage extends StatelessWidget {
  const InternetConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud_off_outlined,
              size: 70,
            ),
            const SizedBox(height: 50),
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 20, color: Colors.black),
                children: [
                  TextSpan(
                    text: "Unable ",
                    style: TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),
                  TextSpan(text: "to connect to the internet"),
                ],
              ),
            ),
            const Text(
              "Please check your internet settings.",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
