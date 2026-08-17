import 'package:flutter/material.dart';
import 'package:nid_mobile/core/widgets/nid_components.dart';
import 'package:nid_mobile/features/ai/data/ai_api.dart';

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  final input = TextEditingController();
  final api = AiApi();
  final messages = <String>['NID AI ready.'];
  bool listening = false;
  bool loading = false;

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
            onPressed: loading ? null : _sendPrompt,
            icon: const Icon(Icons.send),
          ),
        ])
      ]),
    );
  }

  Future<void> _sendPrompt() async {
    final prompt = input.text.trim();
    if (prompt.isEmpty) return;
    setState(() {
      loading = true;
      messages.add('You: $prompt');
      input.clear();
    });
    final response = await api.sendPrompt(prompt: prompt);
    if (!mounted) return;
    setState(() {
      loading = false;
      messages.add('AI: ${response ?? 'AI is unavailable in this environment.'}');
    });
  }
}
