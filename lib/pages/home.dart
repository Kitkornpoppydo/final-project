import 'dart:convert'; // Add this if you are fetching data from an API
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Add this for HTTP requests
import 'package:testflutter/components/infobird.dart';
import 'package:testflutter/pages/page1.dart';
import 'package:testflutter/pages/page2.dart';
import 'package:testflutter/pages/page3.dart';
import 'package:testflutter/pages/page4.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<BirdModel>> bird; // Define the Future variable

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    bird = getBird(); // Initialize the Future variable
  }

  Future<List<BirdModel>> getBird() async {
    final response = await http.get(Uri.parse('http://10.101.237.3:8000/birds/')); // Update with your API URL
    if (response.statusCode == 200) {
      List<dynamic> apidata = jsonDecode(response.body);
      return apidata.map((json) => BirdModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load birds");
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        'title': 'Benjakitti Park',
        'image': 'lib/image/benjakiti park.jpg',
        'page': const Page1(),
      },
      {
        'title': 'Chatuchak Park',
        'image': 'lib/image/chajujak park.jpg',
        'page': const Page2(),
      },
      {
        'title': 'Lumpini Park',
        'image': 'lib/image/lumpini.jpg',
        'page': const Page3(),
      },
      {
        'title': 'Vajirabenjatas Park',
        'image': 'lib/image/rodfai.jpg',
        'page': const Page4(),
      },
    ];

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 270,
                decoration: BoxDecoration(
                  color: const Color(0xFF3b5999).withOpacity(.85),
                ),
              ),
              Positioned(
                top: 40,
                left: 10,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    ListTile(
                      title: Text(
                        "Bird Spotter",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            indicatorColor: Colors.blue,
            labelStyle: const TextStyle(fontSize: 25),
            unselectedLabelStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(text: 'Park'),
              Tab(text: 'Bird'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 5 / 6,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => item['page']),
                          );
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                  child: Image.asset(
                                    item['image']!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        item['title']!,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Bird section using FutureBuilder
                FutureBuilder<List<BirdModel>>(
                  future: bird,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          BirdModel birdModel = snapshot.data![index];
                          return Card(
                            child: ListTile(
                              title: Text(
                                birdModel.bird_common_name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(birdModel.bird_th_name),
                              //leading: Image.network(birdModel.bird_image, width: 80),
                              trailing: const Icon(Icons.arrow_forward_rounded),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => Infobird(birdModel),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text("Could not fetch data"));
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
