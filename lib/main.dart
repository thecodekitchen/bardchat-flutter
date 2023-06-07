import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BardChat(),
    );
  }
}

class ChatResponse {
  String answer;
  String cid;

  ChatResponse({required this.answer, required this.cid});

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(answer: json["answer"], cid: json["cid"]);
  }
}

class BardChat extends StatefulWidget {
  const BardChat({super.key});

  @override
  State<BardChat> createState() => _BardChatState();
}

class _BardChatState extends State<BardChat> {
  TextEditingController kc = TextEditingController();
  TextEditingController cc = TextEditingController();
  TextEditingController qc = TextEditingController();
  String _conversation = 'How can I help?';
  List<String> _ctx = [];
  String _cid = '';
  Client client = Client();

  void addContext(url) {
    _ctx.add(url);
    cc.text = '';
  }

  void submitQuery(q) async {
    qc.text = '';
    setState(() {
      _conversation = '$_conversation\n\nYou: $q';
    });
    var url = Uri.http('localhost:8000', '/ask');
    var body = "";
    if (_ctx == []) {
      if (_cid == '') {
        body = jsonEncode({'q': q});
      } else {
        body = jsonEncode({'q': q, 'cid': _cid});
      }
    } else {
      if (_cid == '') {
        body = jsonEncode({'q': q, 'ctx': _ctx});
      } else {
        body = jsonEncode({'q': q, 'ctx': _ctx, 'cid': _cid});
      }
    }
    Map<String, String> headers = {
      "Authorization": kc.text,
      "Content-Type": "application/json"
    };
    var response = await client.post(url, headers: headers, body: body);
    ChatResponse chat =
        ChatResponse.fromJson(jsonDecode(jsonDecode(response.body)));
    setState(() {
      _cid = chat.cid;
      _conversation = '$_conversation\n\nBard: ${chat.answer}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Column(children: [
        TextField(controller: kc),
        TextField(controller: cc, onSubmitted: (url) => {addContext(url)}),
        TextField(controller: qc, onSubmitted: (q) => {submitQuery(q)}),
        Container(
            height: 494,
            child: Markdown(
                data: _conversation, selectable: true, shrinkWrap: true))
      ]),
    );
  }
}
