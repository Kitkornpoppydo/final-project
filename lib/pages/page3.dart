import 'package:flutter/material.dart';

class Page3 extends StatefulWidget {
  Page3();

  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Lumpini Park"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Hero(
                tag: "blogImage",
                child: Image.asset(
                  "lib/image/lumpini.jpg",
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
                    Container(
                      width: size.width / 2,
                      child: const Text(
                        "สวนลุมพินี",
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
                  "สวนลุมพินี (Lumpini Park Thailand) เป็นสวนสาธารณะแห่งแรกของกรุงเทพมหานคร มีลักษณะเป็น สวนอเนกประสงค์ ใช้ประโยชน์ในด้านต่าง ๆ รวมกันหลายอย่าง ทั้งกิจกรรมนันทนาการหลากหลายที่จัดเตรียมไว้บริการประชาชน ร่มรื่นด้วยต้นไม้ขนาดใหญ่มีอยู่ทั่วสวน งดงามด้วยสวนไม้ดอกไม้ประดับหลากหลายชนิด อีกทั้งมีสระน้ำกว้างใหญ่ ในอดีต นอกจากสวนลุมพินีจะเป็นสวนสาธารณะ เป็นสถานที่ออกกำลังกายแล้ว สวนลุมพินียังเป็นสถานที่จัดกิจกรรม จัดงานฉลอง เป็นสถานจัดงานลีลาศ งานบอล และงานอื่น ๆ อีกมากมาย ปัจจุบัน สวนลุมพินียังคงเป็นสวนสาธารณะยอดนิยมที่มีผู้คนไปพักผ่อนหย่อนใจ ทำกิจกรรมต่าง ๆ ไม่ว่าจะออกกำลังกาย รำมวยจีน เล่นเกม ฟังดนตรี เรียนลีลาศ อ่านหนังสือที่ห้องสมุด และบางครั้งก็มีการจัดงานจัดกิจกรรมต่าง ๆ บ้าง จุดน่าสนใจในสวน -พระบรมรูปรัชกาลที่ 6 สร้างในปี 2485 ",
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
