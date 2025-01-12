import 'dart:io'; // For using File
import 'dart:typed_data'; // For Uint8List

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tts/flutter_tts.dart'; // Import flutter_tts

class GeminiHome extends StatefulWidget {
  final String initialText; // Added to accept initial text

  const GeminiHome({super.key, this.initialText = ""}); // Constructor

  @override
  State<GeminiHome> createState() => _GeminiHomeState();
}

class _GeminiHomeState extends State<GeminiHome> {
  final Gemini gemini = Gemini.instance;
  final FlutterTts flutterTts = FlutterTts(); // Initialize text-to-speech
  List<ChatMessage> messages = [];
  ChatUser currentUser = ChatUser(id: '0', firstName: "user");
  ChatUser geminiUser = ChatUser(
    id: '1',
    firstName: 'Jarvis',
    profileImage: 'assets/images/pro1.jpg', // Use asset path as a string
  );

  @override
  void initState() {
    super.initState();
    // Send the initial text if it's provided
    if (widget.initialText.isNotEmpty) {
      _sendInitialMessage(widget.initialText);
    }
  }

  void _sendInitialMessage(String text) {
    final chatMessage = ChatMessage(
      user: currentUser,
      createdAt: DateTime.now(),
      text: text,
    );
    _sendMessage(chatMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Jarvis",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Icon(Icons.menu),
        actions: [
          IconButton(
            icon: Icon(Icons.mic_off),
            onPressed: () async {
              await flutterTts.stop();
            },
          ),
        ],
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return DashChat(
      inputOptions: InputOptions(trailing: [
        IconButton(
          onPressed: _sendMediaMessage,
          icon: Icon(Icons.image),
        ),
      ]),
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
      messageOptions: MessageOptions(
        currentUserContainerColor:
            Colors.lightBlue.shade300, // User message background color
        containerColor: Colors.grey.shade300, // Bot message background color
      ),
    );
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });

    try {
      String question = chatMessage.text;
      List<Uint8List>? images;
      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [
          File(chatMessage.medias!.first.url).readAsBytesSync(),
        ];
      }
      gemini
          .streamGenerateContent(
        question,
        images: images,
      )
          .listen((event) {
        String response = event.content?.parts
                ?.fold("", (previous, current) => "$previous$current") ??
            "";

        // Sanitize the response
        response = _sanitizeResponse(response);

        ChatMessage message = ChatMessage(
          user: geminiUser,
          createdAt: DateTime.now(),
          text: response,
        );

        setState(() {
          messages = [message, ...messages];
        });

        // Speak the response
        flutterTts.speak(response);
      });
    } catch (e) {
      print(e);
    }
  }

  void _sendMediaMessage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
        user: currentUser,
        createdAt: DateTime.now(),
        text: "Describe this picture?",
        medias: [
          ChatMedia(url: file.path, fileName: '', type: MediaType.image),
        ],
      );
      _sendMessage(chatMessage);
    }
  }

  // Function to sanitize the response
  String _sanitizeResponse(String response) {
    // Remove "Parts(text:" and any other unwanted words
    return response
        .replaceAll(RegExp(r"Parts\(text:\s*"), "")
        .replaceAll(")", "")
        .trim();
  }
}
