import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Project Information',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey.shade100,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Project Title:Conversational Assistant "Jarvis"',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade700,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Project Description:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade700,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'The "Jarvis" project is an AI-driven chatbot application developed using Flutter, leveraging the dash_chat_2 package to create a responsive and interactive chat interface. This application aims to provide users with a seamless conversational experience, allowing them to interact with a virtual assistant named "Jarvis."',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Text(
              'Key features of the project include:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade700,
              ),
            ),
            SizedBox(height: 8.0),
            _buildFeatureText(
              'Interactive Chat Interface: The chat interface is designed using dash_chat_2, offering a smooth and intuitive user experience. Messages are displayed in a clean, organized manner, ensuring readability and ease of interaction.',
            ),
            _buildFeatureText(
              'AI Integration with Gemini: The core of Jarvis\'s conversational abilities is powered by the Gemini API, a sophisticated content generation service. Jarvis can process user inputs and generate contextually relevant responses, making interactions feel natural and engaging.',
            ),
            _buildFeatureText(
              'Voice Feedback: To enhance user engagement, the application integrates the flutter_tts (text-to-speech) plugin. This feature enables Jarvis to vocalize its responses, providing an auditory element to the conversation, which is particularly useful for accessibility and multitasking scenarios.',
            ),
            _buildFeatureText(
              'Media Handling: The application supports the sharing of images within the chat. Users can upload images, and Jarvis can process these images to provide descriptive feedback or perform other relevant actions based on the image content.',
            ),
            _buildFeatureText(
              'Customizable and Extensible: The project is built with flexibility in mind, allowing for easy customization and extension of features. This makes it suitable for a variety of use cases, such as customer support, personal assistance, or even educational tools.',
            ),
            SizedBox(height: 16.0),
            Text(
              'Project Goals:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade700,
              ),
            ),
            SizedBox(height: 8.0),
            _buildGoalText(
              'To create a user-friendly, AI-powered chat application that provides meaningful and context-aware interactions.',
            ),
            _buildGoalText(
              'To leverage the power of Gemini\'s API to enable advanced content generation and response formulation.',
            ),
            _buildGoalText(
              'To enhance the user experience with multimedia capabilities, including image processing and voice feedback.',
            ),
            _buildGoalText(
              'To build a foundation for further development, allowing the integration of additional features such as natural language understanding, sentiment analysis, or other AI-driven functionalities.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        '• $text',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildGoalText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        '• $text',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
