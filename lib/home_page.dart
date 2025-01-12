import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jarvis/feature_box.dart';
import 'package:jarvis/info.dart';
import 'package:jarvis/openai_service.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:jarvis/gemini_home.dart'; // Import the GeminiHome screen

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText = SpeechToText();
  String lastWords = '';
  final OpenAiService openAiService = OpenAiService();

  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
    // Navigate to GeminiHome with the recognized text
    if (lastWords.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GeminiHome(initialText: lastWords),
        ),
      );
    }
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
    print('Recognized Words: ${result.recognizedWords}');
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Jarvis",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        leading: Icon(
          Icons.tablet_android,
          color: Colors.black,
        ),
        backgroundColor: Colors.grey.shade100,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InfoPage(),
                ),
              );
              // Handle info button press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purpleAccent, Colors.blueAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 133,
                    width: 133,
                    margin: EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/images/pro1.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              margin: EdgeInsets.symmetric(horizontal: 40).copyWith(top: 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent.shade100, Colors.cyan.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(20).copyWith(
                  topLeft: Radius.zero,
                ),
              ),
              child: Text(
                "Good Morning, What task can I do for you?",
                style: TextStyle(
                  color: Colors.indigo.shade700,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 20, left: 22),
              child: Text(
                "Here are a few features",
                style: TextStyle(
                  color: Colors.indigo.shade700,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Column(
              children: [
                FeatureBox(
                  color: Colors.lightBlue.shade100,
                  headerText: "Gemini",
                  descriptionText:
                      "A smarter way to stay organized and informed with Gemini",
                ),
                FeatureBox(
                  color: Colors.green.shade100,
                  headerText: "Smart Voice Assistant",
                  descriptionText:
                      "Get the best of both worlds with a voice assistant powered",
                ),
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GeminiHome()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Button background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(
                "Go to Gemini Chat",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
          } else if (speechToText.isListening) {
            await stopListening(); // Stop listening and navigate
          } else {
            initSpeechToText();
          }
          print("object${startListening()}");
        },
        backgroundColor: Colors.transparent, // Transparent background
        elevation: 0, // Remove shadow
        child: Icon(Icons.mic,
            color: Colors.deepPurpleAccent.shade100, size: 30.0),
      ),
    );
  }
}
