import 'package:flutter/material.dart';


class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chajujak Park"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Hero(
                tag: "blogImage",
                child: Image.asset(
                  "lib/image/chajujak park.jpg",
                  height: 400.0,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
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
                    SizedBox(
                      width: size.width / 2,
                      child: const Text(
                        "สวนจตุจักร",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
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
                const Text(
                 "อุทยานสวนจตุจักร รวมสามเป็นหนึ่งอุทยานระดับโลก สวนวชิรเบญจทัศ สวนสมเด็จพระนางเจ้าสิริกิติ์ และสวนจตุจักรจากแผนโครงการในการพัฒนาพื้นที่สวนสาธารณะในการดูแลของ กทม. นั้น สวนในพื้นที่ของเขตจตุจักรและจอมพล มีแผนการปรับปรุงทางเชื่อมสามสวนสาธารณะบนพื้นที่ของถนนกำแพงเพชร 3 ได้แก่ สวนวชิรเบญจทัศ หรือ สวนรถไฟ, สวนสมเด็จพระนางเจ้าสิริกิติ์ และสวนจตุจักร เพื่อทำเป็น อุทยานสวนจตุจักร บนพื้นที่กว่า 727 ไร่ ซึ่งเป็นพื้นที่ศูนย์กลางการคมนาคมของกรุงเทพมหานคร ทำให้ อุทยานสวนจตุจักร กลายมาเป็นสวนสาธารณะที่มีพื้นที่ใหญ่ที่สุดในกรุงเทพมหานคร ใหญ่กว่าสวนหลวง ร.9 ที่มีพื้นที่ 500 ไร่",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    //fontFamily: ""
                  ),
                ),
                //Container(
                // height: 64,
                // width: size.width,
                //decoration: BoxDecoration(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
