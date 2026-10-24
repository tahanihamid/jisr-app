import 'package:flutter/material.dart';
import '../theme/colors.dart';

class _AdvisorMessage {
  final String text;
  final bool isUser;
  
  _AdvisorMessage({required this.text, required this.isUser});
}

class AdvisorScreen extends StatefulWidget {
  const AdvisorScreen({super.key});

  @override
  State<AdvisorScreen> createState() => _AdvisorScreenState();
}

class _AdvisorScreenState extends State<AdvisorScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<_AdvisorMessage> _messages = [
    _AdvisorMessage(
      isUser: false,
      text: 'Hello Tahani! I am your AI Career Advisor. I can help you develop essential professional skills, prepare for interviews, master time management, and build strong communication.',
    ),
  ];

  final List<String> _quickPrompts = [
    'How can I improve my communication skills?',
    'Tips for effective time management & productivity',
    'How to build leadership & teamwork skills?',
    'Ace job interviews and CV preparation',
  ];

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(_AdvisorMessage(isUser: true, text: text.trim()));
    });

    _messageController.clear();
    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      setState(() {
        _messages.add(_AdvisorMessage(isUser: false, text: _generateResponse(text)));
      });
      _scrollToBottom();
    });
  }

  String _generateResponse(String input) {
    final lower = input.toLowerCase();

    if (lower.contains('communication') || lower.contains('speak') || lower.contains('listen')) {
      return 'Effective communication relies on active listening, concise messaging, and emotional intelligence. Always tailor your message to your audience and seek regular feedback.';
    } else if (lower.contains('time') || lower.contains('productivity') || lower.contains('manage')) {
      return 'Try techniques like time blocking or the Pomodoro technique. Prioritize tasks using the Eisenhower Matrix (urgent vs. important) and set clear daily boundaries.';
    } else if (lower.contains('leadership') || lower.contains('team') || lower.contains('collaboration')) {
      return 'Leadership is about empathy, clear delegation, and accountability. In team settings, focus on transparent updates, active problem solving, and appreciating peer contributions.';
    } else if (lower.contains('interview') || lower.contains('cv') || lower.contains('job')) {
      return 'Structure your answers using the STAR method (Situation, Task, Action, Result). Highlight both your tangible achievements and transferable soft skills like problem-solving and adaptability.';
    }
    return 'Developing general professional competencies takes deliberate practice. Break this down into small weekly habits and observe feedback from mentors and peers.';
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_messages.length <= 1)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: brandColor.withOpacity(0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Explore Core Skills & Guidance',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: brandColor,
                  ),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _quickPrompts.map((prompt) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ActionChip(
                          label: Text(
                            prompt,
                            style: const TextStyle(fontSize: 12),
                          ),
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.grey.shade300),
                          onPressed: () => _sendMessage(prompt),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final msg = _messages[index];

              return Align(
                alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  constraints: const BoxConstraints(maxWidth: 300),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: msg.isUser ? brandColor : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(14),
                      topRight: const Radius.circular(14),
                      bottomLeft: Radius.circular(msg.isUser ? 14 : 2),
                      bottomRight: Radius.circular(msg.isUser ? 2 : 14),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    msg.text,
                    style: TextStyle(
                      color: msg.isUser ? Colors.white : Colors.black87,
                      fontSize: 14,
                      height: 1.35,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    textInputAction: TextInputAction.send,
                    onSubmitted: _sendMessage,
                    decoration: InputDecoration(
                      hintText: 'Ask advisor anything...',
                      hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: brandColor,
                  radius: 20,
                  child: IconButton(
                    icon: const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                    onPressed: () => _sendMessage(_messageController.text),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}