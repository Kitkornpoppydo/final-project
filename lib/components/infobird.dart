import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// BirdModel class
class BirdModel {
  late String bird_common_name;
  late String bird_th_name;
  late String bird_anatomy_detail;
  late String bird_behavior;
  late String bird_food;
  late String bird_image;
  late int id;

  BirdModel({
    required this.bird_common_name,
    required this.bird_th_name,
    required this.bird_anatomy_detail,
    required this.bird_behavior,
    required this.bird_food,
    required this.bird_image,
    required this.id,
  });

  factory BirdModel.fromJson(dynamic json) {
    return BirdModel(
      id: json['id'] as int,
      bird_common_name: json['bird_common_name'] as String,
      bird_th_name: json['bird_th_name'] as String,
      bird_anatomy_detail: json['bird_anatomy_detail'] as String,
      bird_behavior: json['bird_behavior'] as String,
      bird_food: json['bird_food'] as String,
      bird_image: json['bird_image'] as String,
    );
  }
}

// Mobird class
class Mobird extends StatefulWidget {
  const Mobird({super.key});

  @override
  State<Mobird> createState() => _MobirdState();
}

class _MobirdState extends State<Mobird> {
  Future<List<BirdModel>> getBird() async {
    final response =
        await http.get(Uri.parse('http://10.101.237.3:8000/birds/'));
  
    if (response.statusCode == 200) {
      // Decode the response body to handle UTF-8 encoding
      List<dynamic> apidata = jsonDecode(utf8.decode(response.bodyBytes));
      List<BirdModel> modeldata =
          apidata.map((json) => BirdModel.fromJson(json)).toList();
      print(modeldata);
      return modeldata;
    } else {
      throw Exception("Fix: Something went wrong!!");
    }
  }

  late Future<List<BirdModel>> bird;

  @override
  void initState() {
    super.initState();
    bird = getBird();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<BirdModel>>(
          future: bird,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final birdModel = snapshot.data![index];
                  return ListTile(
                    title: Text(birdModel.bird_common_name),
                    subtitle: Text(birdModel.bird_th_name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Infobird(birdModel),
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              return const Center(child: Text("Could not fetch data"));
            }
          },
        ),
      ),
    );
  }
}

// Infobird class
class Infobird extends StatelessWidget {
  final BirdModel birdModel;

  const Infobird(this.birdModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(birdModel.bird_common_name),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Image.network(birdModel.bird_image),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    birdModel.bird_common_name,
                    style: const TextStyle(fontSize: 25,
                    fontFamily: "NotoSansThai"),
                  ),
                  const Divider(thickness: 1, height: 32),
                  Text(
                    birdModel.bird_anatomy_detail,
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "อาหาร",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    birdModel.bird_food,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "ถิ่นอาศัย",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    birdModel.bird_behavior,
                    style: const TextStyle(fontSize: 13),
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
