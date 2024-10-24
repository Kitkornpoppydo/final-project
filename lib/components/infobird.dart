import 'package:flutter/material.dart';
import 'package:testflutter/modelbird/modelbird1.dart';

class Infobird extends StatelessWidget {
  final Modelbird1 bird1;

  Infobird(this.bird1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bird1.title),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView( // scrollview
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: "blogImage",
                  child: Image.asset(bird1.image),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 24.0,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        child: Text(
                          bird1.title.toString(),
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.black.withOpacity(0.8),
                    height: 32,
                  ),
                  Text(
                    bird1.description.toString(), 
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        child: const Text(
                          "อาหาร",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.black.withOpacity(0.8),
                    height: 32,
                  ),
                  Text(
                    bird1.food.toString(), 
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 30),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        child: const Text(
                          "ถิ่นอาศัย",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                   Divider(
                    thickness: 1,
                    color: Colors.black.withOpacity(0.8),
                    height: 32,
                  ),
                  Text(
                    bird1.address.toString(), 
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
