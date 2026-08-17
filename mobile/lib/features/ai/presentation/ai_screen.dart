import 'package:flutter/material.dart';
import 'package:nid_mobile/core/widgets/nid_components.dart';

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  final input = TextEditingController();
  final messages = <String>['NID AI ready.'];
  bool listening = false;

  @override
  void dispose() {
    input.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Assistant')),
      body: Column(children: [
        Expanded(child: ListView(children: messages.map((m) => ListTile(title: Text(m))).toList())),
        Row(children: [
          Expanded(child: NIDTextField(controller: input, label: 'Ask NID AI')),
          IconButton(
            onPressed: () => setState(() => listening = !listening),
            icon: Icon(listening ? Icons.mic : Icons.mic_none),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                messages.add('You: ${input.text}');
                messages.add('AI: AI is unavailable in this environment.');
                input.clear();
              });
            },
            icon: const Icon(Icons.send),
          ),
        ])
      ]),
    );
  }
}
