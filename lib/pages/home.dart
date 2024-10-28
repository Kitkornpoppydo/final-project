import 'package:flutter/material.dart';
import 'package:testflutter/components/infobird.dart';
import 'package:testflutter/modelbird/modelbird1.dart';
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

  @override
  void initState() {
    super.initState();
    // Initialize the TabController with 2 tabs
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose the controller when no longer needed
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
              // Background with overlay color
              Container(
                height: 270,
                decoration: BoxDecoration(
                  color: const Color(0xFF3b5999).withOpacity(.85),
                ),
              ),
              // Positioned IconButton inside a Container
              Positioned(
                top: 40, // Adjust as needed
                left: 10, // Adjust as needed
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
          // Tab Bar
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
              Tab(text: 'park'),
              Tab(text: 'bird'),
            ],
          ),
          // Expanded section for park
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
                // Expanded section for bird
                ListView.builder(
                  itemCount: birdList.length,
                  itemBuilder: (context, index) {
                    Modelbird1 bird1 = birdList[index];
                    return Card(
                      child: ListTile(
                        title: Text(
                          bird1.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(bird1.nameeng),
                        leading: Image.asset(bird1.image,width: 80,),
                        trailing: const Icon(Icons.arrow_forward_rounded),
                        // เชื่อมหน้า infobird
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Infobird(bird1), 
                            ),
                          );
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}




