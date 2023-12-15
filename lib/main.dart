import 'package:flutter/material.dart';
import 'package:morseth_finalprojectpart2/apiModel.dart';
import 'package:morseth_finalprojectpart2/apiService.dart';
import 'package:morseth_finalprojectpart2/secureStorage.dart';
import 'package:morseth_finalprojectpart2/dataDisplay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

final ApiService _apiService = ApiService();

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Morseth Mobile App',
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 121, 191),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Please sign in',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            FutureBuilder<Widget>(
              future: _buildLoginUI(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return snapshot.data ?? Container();
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 3.0, right: 3.0),
              child: FutureBuilder<Widget>(
                future: _buildVersionField(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return snapshot.data ?? Container();
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AboutPage()),
          );
        },
        style: TextButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 0, 121, 191),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        child: Text(
          'About',
          style: TextStyle(
            fontSize: 20,
            color: Colors.cyan.shade100,
          ),
        ),
      ),
      backgroundColor: Colors.cyan.shade100,
    );
  }

  Future<Widget> _buildVersionField() async {
    String appVersion = '1.7.4';

    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Version: $appVersion',
          style: const TextStyle(fontSize: 15.0),
        ),
      ),
    );
  }

  Future<Widget> _buildLoginUI() async {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(labelText: 'Username'),
        ),
        TextField(
          controller: _passwordController,
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () async {
            await _login();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromARGB(255, 0, 121, 191)),
            foregroundColor:
                MaterialStateProperty.all<Color>(Colors.cyan.shade100),
          ),
          child: const Text('Sign in'),
        ),
      ],
    );
  }

  Future<void> _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      SecureStorage secureStorage = SecureStorage();
      await secureStorage.saveCredentials('test', 'test');

      String? storedUsername = await secureStorage.getUsername();
      String? storedPassword = await secureStorage.getPassword();

      ApiModel apiData = await _apiService.fetchData();
      setState(() {
        if (username == storedUsername && password == storedPassword) {
          _showSnackBar("Login success");

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => dataDisplay(apiData: apiData),
            ),
          );
        } else if (username != storedUsername && password == storedPassword) {
          _showSnackBar('Incorrect username. Please try again.');
        } else if (username == storedUsername && password != storedPassword) {
          _showSnackBar('Incorrect password. Please try again.');
        } else {
          _showSnackBar('Incorrect login information.');
        }
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Morseth Mobile App',
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.cyan.shade100,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "Can't get enough of APIs? You're in the right place. This is an app that uses an API of APIs.",
                style: TextStyle(fontSize: 19.0),
                textAlign: TextAlign.center),
            Text(""),
            Text(""),
            Text(
              "Developed by Heidi Morseth for CMSC 2204",
              style: TextStyle(fontSize: 19.0),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.cyan.shade100,
    );
  }
}
