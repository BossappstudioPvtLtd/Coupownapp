import 'dart:math';

import 'package:coupown/Const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill/flutter_quill.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TextEditorQuill extends StatefulWidget {
  const TextEditorQuill({super.key});

  @override
  _TextEditorQuillState createState() => _TextEditorQuillState();
}

class _TextEditorQuillState extends State<TextEditorQuill> {
  late quill.QuillController _controller;
  final FocusNode _focusNode = FocusNode();
  final String _documentKey = 'saved_document'; // Key to save/load document

  @override
  void initState() {
    super.initState();
    _controller = quill.QuillController.basic();
    _loadDocument();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // Load document from shared preferences
  Future<void> _loadDocument() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDocument = prefs.getString(_documentKey);
    if (savedDocument != null) {
      final document = quill.Document.fromJson(
          List<Map<String, dynamic>>.from(prefs.get(_documentKey) as List));
      setState(() {
        _controller = quill.QuillController(
          document: document,
          selection: const TextSelection.collapsed(offset: 0),
        );
      });
    }
  }

  // Validate if the document is empty
  bool _validateDocument() {
    final documentText = _controller.document.toPlainText();
    if (documentText.trim().isEmpty) { // Check for empty or whitespace-only content
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Document cannot be empty!')),
      );
      return false;
    }
    return true;
  }

  // Save document to shared preferences
  Future<void> _saveDocument() async {
    if (!_validateDocument()) return; // Only save if valid
    final prefs = await SharedPreferences.getInstance();
    final jsonDocument = _controller.document.toDelta().toJson();
    await prefs.setString(_documentKey, jsonDocument.toString());
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Document saved!')),
    );
  }

  // Clear the saved document
  Future<void> _clearDocument() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_documentKey);
    setState(() {
      _controller = quill.QuillController.basic();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Document cleared!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Description'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(8),
                  child: QuillSimpleToolbar(
                    controller: _controller,
                    configurations: QuillSimpleToolbarConfigurations(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      sectionDividerColor: appColorAccent,
                      toolbarIconAlignment: WrapAlignment.start,
                      toolbarSectionSpacing: sqrt2,
                      multiRowsDisplay: false,
                      toolbarSize: 30,
                      showFontSize: true,
                      showJustifyAlignment: true,
                      showListCheck: true,
                      showCodeBlock: true,
                      showInlineCode: true,
                      showQuote: true,
                      showStrikeThrough: true,
                      showUnderLineButton: true,
                      showBoldButton: true,
                      showItalicButton: true,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  color: const Color.fromARGB(235, 247, 247, 250),
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: quill.QuillEditor(
                      scrollController: ScrollController(),
                      focusNode: _focusNode,
                      controller: _controller,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
