import 'package:coupown/Const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SearchWidgets extends StatefulWidget {
  const SearchWidgets({super.key});

  @override
  _SearchWidgetsState createState() => _SearchWidgetsState();
}

class _SearchWidgetsState extends State<SearchWidgets> {
  // Text controller for search input
  TextEditingController searchController = TextEditingController();

  // Variables for speech recognition
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _voiceInput = '';

  @override
  void initState() {
    super.initState();
    // Initialize SpeechToText
    _speech = stt.SpeechToText();
  }

  // Method to start or stop listening to voice input
  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (val) {
          setState(() {
            _voiceInput = val.recognizedWords;
            searchController.text = _voiceInput;  // Update the text field with voice input
            // Optionally, you can also trigger a search/filter here if needed
          });
        });
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(32),
        color: Colors.white,
        child: SizedBox(
          height: 50, // Adjust this value to set the desired height
          child: Center(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Adjust the vertical padding to make the height smaller
                hintText: "Search...",
                hintStyle: const TextStyle(color: iconColorSecondary),
                prefixIcon: const Icon(Icons.search, color: iconColorSecondary), // Icon on the left side
                suffixIcon: IconButton(
                  icon: const Icon(Icons.mic, color: iconColorSecondary),  // Mic icon for voice input
                  onPressed: _listen,  // Start listening on mic press
                ),
                border: InputBorder.none, // Removes the baseline (underline)
              ),
              onChanged: (value) {
                // Optionally, you can handle search input changes here
              },
            ),
          ),
        ),
      ),
    );
  }
}
