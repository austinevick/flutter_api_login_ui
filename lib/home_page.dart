import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isVisible = true;
  String get text => isVisible ? '200,000' : '******';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.purple[300],
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () =>
                              setState(() => isVisible = !isVisible),
                          icon: isVisible
                              ? const Icon(Icons.visibility,
                                  color: Colors.white)
                              : const Icon(Icons.visibility_off,
                                  color: Colors.white)),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Primary Wallet',
                          style: TextStyle(color: Colors.white)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('NGN', style: TextStyle(color: Colors.grey[300])),
                        Text(text,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
