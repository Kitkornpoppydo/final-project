import 'package:flutter/material.dart';


class Page4 extends StatefulWidget {
  const Page4({super.key});

  @override
  _Page4State createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("VajirabenjatasPark"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Hero(
                tag: "blogImage",
                child: Image.asset(
                  "lib/image/rodfai.jpg",
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
                        "สวนรถไฟ",
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
                 "สวนสาธารณะแห่งนี้ถูกสร้างในแนวคิด “สวนครอบครัว” ที่ตระเตรียมกิจกรรมหลากหลายไว้ดึงดูดความสนใจของสมาชิกทุกวัยในครอบครัวแทรกอยู่ตามจุดต่าง ๆ ในพื้นที่โล่งกว้าง และเขียวขจี สดชื่น สบายตา ให้ความรู้สึกอิสระ มีเนินหญ้าสลับกับพื้นราบกว้างมีสิ่งอำนวยความสะดวกพื้นฐานสำหรับสวนสาธารณะครบครัน และเป็น “สวนสาธารณะในฝันของนักปั่นจักรยาน” ด้วยเส้นทางจักรยานระยะทาง 3.2 กิโลเมตร ลัดเลาะดงไม้ ไต่เนินไปรอบนอกสวน หรือจะเลือกเดินชมธรรมชาติ วิ่งออกกำลังก็ทำได้ในเส้นทางใหญ่ภายในบริเวณสวน นอกจากนี้ในช่วงปี 2560 ผู้ว่าราชการกรุงเทพมหานคร พลตำรวจเอก อัศวิน ขวัญเมือง ได้มีนโยบายปลูกต้นรวงผึ้ง เพื่อเฉลิมพระเกียรติสมเด็จพระเจ้าอยู่หัวมหาวชิราลงกรณ บดินทรเทพยวรางกูร บริเวณลานรวงผึ้ง   ในพื้นที่สวนวชิรเบญจทัศ จำนวน 110 ต้น",
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
