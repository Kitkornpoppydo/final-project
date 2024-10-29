import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:testflutter/main_screen.dart';
import 'package:testflutter/pages/Forgotpass.dart';
import 'package:testflutter/pages/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  final storage = const FlutterSecureStorage();

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final url = Uri.parse('http://10.101.237.3:8000/users/login/');
      try {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'email': email, 'password': password}),
        );

        // ตรวจสอบสถานะการตอบกลับ
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          String? access = data['access_token'];
          String? refresh = data['refresh_token'];

          if (access != null && refresh != null) {
            // บันทึกโทเค็นอย่างปลอดภัย
            await storage.write(key: 'access', value: access);
            await storage.write(key: 'refresh', value: refresh);

            // นำทางไปยังหน้าหลักของแอป โดยส่งค่า email
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login successful')),
            );
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MainScreen(email: email)),
            );
          } else {
            // ถ้าไม่มี access หรือ refresh ในการตอบกลับ
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Token not found in response')),
            );
          }
        } else {
          // ตรวจสอบข้อความแสดงข้อผิดพลาดจากเซิร์ฟเวอร์
          final errorData = json.decode(response.body);
          String errorMessage = errorData['message'] ?? 'Invalid credentials';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        }
      } catch (e) {
        print('Error: $e'); // เพิ่มการพิมพ์ข้อผิดพลาด
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An error occurred, please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Image.asset(
                  "lib/image/logobird.png",
                  height: 200,
                ),
                const SizedBox(height: 50),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) {
                    email = value ?? ''; // ใช้ค่าเริ่มต้นถ้า value เป็น null
                  },
                  validator: (value) {
                    return value!.isEmpty ? 'Please enter your email' : null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  onSaved: (value) {
                    password = value ?? ''; // ใช้ค่าเริ่มต้นถ้า value เป็น null
                  },
                  validator: (value) {
                    return value!.isEmpty ? 'Please enter your password' : null;
                  },
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Forgotpass()),
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: login,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) => const Register(),
                          ),
                        );
                      },
                      child: const Text("Sign Up"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                InkWell(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text(
                        "Sign up with Gmail",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
