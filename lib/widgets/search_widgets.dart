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
            searchController.text = _voiceInput; // Update the text field with voice input
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
    padding: EdgeInsets.all(screenWidth * 0.02), 
      child: Material(elevation: 5, borderRadius: BorderRadius.circular(screenWidth * 0.08),color: Colors.white,
        child: SizedBox(height: screenHeight * 0.07, 
          child: Center(child: TextField(controller: searchController,
            decoration: InputDecoration(contentPadding: EdgeInsets.symmetric( vertical: screenHeight * 0.01, horizontal: screenWidth * 0.04, ),
              hintText: "Search...", hintStyle: const TextStyle(color: iconColorSecondary),
                prefixIcon: Icon( Icons.search, color: iconColorSecondary, size: screenWidth * 0.06, ), 
                  suffixIcon: IconButton( icon: Icon( Icons.mic,color: iconColorSecondary, size: screenWidth * 0.06,), onPressed: _listen,),
                    border: InputBorder.none, ),onChanged: (value) {},
            ),
          ),
        ),
      ),
    );
  }
}
