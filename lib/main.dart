import 'package:flutter/material.dart';
import 'package:translator/translator.dart'; // Assurez-vous d'ajouter cette dépendance

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Translator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TranslatorScreen(),
    );
  }
}

class TranslatorScreen extends StatefulWidget {
  @override
  _TranslatorScreenState createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  TextEditingController _sourceTextController = TextEditingController();
  TextEditingController _translatedTextController = TextEditingController();
  List<String> _languages = ['en', 'fr', 'es', 'de', 'ar', 'it', 'ja', 'ko', 'ru']; // Ajoutez d'autres langues ici
  String _selectedLanguage = 'en';

  void _translateText() async {
    String sourceText = _sourceTextController.text;
    String targetLanguage = _selectedLanguage;

    final translator = GoogleTranslator();
    Translation translation = await translator.translate(sourceText, to: targetLanguage);

    setState(() {
      _translatedTextController.text = translation.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Translator App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Translate Text:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _sourceTextController,
              decoration: InputDecoration(labelText: 'Source Text'),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
              },
              items: _languages.map<DropdownMenuItem<String>>(
                    (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _translateText,
              child: Text('Translate'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _translatedTextController,
              decoration: InputDecoration(labelText: 'Translated Text'),
            ),
          ],
        ),
      ),
    );
  }
}
