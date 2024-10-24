import 'package:flutter/material.dart';


class Page1 extends StatefulWidget {
  Page1();

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Benchakitti Park"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Hero(
                tag: "blogImage",
                child: Image.asset(
                  "lib/image/benjakiti park.jpg",
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
                        "สวนป่าเบญจกิติ",
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
                  "สวนเบญจกิติ (Benchakitti Park) เป็นสวนสาธารณะระดับย่านเพื่อเฉลิมพระเกียรติสมเด็จพระนางเจ้าสิริกิติ์ พระบรมราชินีนาถ พระบรมราชชนนีพันปีหลวง ในโอกาสมหามงคลเฉลิมพระชนมพรรษา 5 รอบ เมื่อปี พ.ศ. 2535 ตั้งอยู่ในบริเวณพื้นที่โรงงานยาสูบเดิม ข้างศูนย์การประชุมแห่งชาติสิริกิติ์ ถนนรัชดาภิเษก ช่วงระหว่างถนนพระรามที่ 4 กับถนนสุขุมวิท ในพื้นที่แขวงคลองเตย เขตคลองเตย กรุงเทพมหานคร",
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
