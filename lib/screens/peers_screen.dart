import 'package:flutter/material.dart';
import '../theme/colors.dart';

class Peer {
  final String name;
  final String major;
  final String year;
  final String email;
  final String phone;
  final String bio;
  final String avatar;
  final List<String> skills;

  const Peer({
    required this.name,
    required this.major,
    required this.year,
    required this.email,
    required this.phone,
    required this.bio,
    required this.avatar,
    required this.skills,
  });
}

class PeersScreen extends StatefulWidget {
  const PeersScreen({super.key});

  @override
  State<PeersScreen> createState() => _PeersScreenState();
}

class _PeersScreenState extends State<PeersScreen> {
  final List<String> _filters = [
    'All Topics',
    'Flutter & Dart',
    'Machine Learning',
    'Cyber Security',
    'Backend & APIs',
    'UI/UX Design',
  ];

  late String _selectedFilter;

  final List<Peer> _peers = const [
    Peer(
      name: 'Shahad Ahmed',
      major: 'Software Engineering',
      year: 'Senior (Year 4)',
      email: 'shahad.ahmed@jisr.edu',
      phone: '+90 532 445 9812',
      bio: 'Focused on cross-platform mobile apps and clean architecture.',
      avatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
      skills: ['Flutter & Dart', 'UI/UX Design'],
    ),
    Peer(
      name: 'Volkan Demir',
      major: 'Computer Engineering',
      year: 'Junior (Year 3)',
      email: 'volkan.demir@jisr.edu',
      phone: '+90 505 881 0934',
      bio: 'Working on deep learning projects, NLP, and model optimization.',
      avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
      skills: ['Machine Learning', 'Backend & APIs'],
    ),
    Peer(
      name: 'Safa Mansour',
      major: 'Software Engineering',
      year: 'Senior (Year 4)',
      email: 'safa.mansour@jisr.edu',
      phone: '+90 544 239 7711',
      bio: 'Interested in cloud infrastructure security and vulnerability testing.',
      avatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
      skills: ['Cyber Security', 'Backend & APIs'],
    ),
    Peer(
      name: 'Omar Faruk',
      major: 'Information Systems',
      year: 'Sophomore (Year 2)',
      email: 'omar.faruk@jisr.edu',
      phone: '+90 555 912 4408',
      bio: 'Building relational database schemas and REST endpoints.',
      avatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150',
      skills: ['Backend & APIs'],
    ),
    Peer(
      name: 'Nour Al-Huda',
      major: 'Software Engineering',
      year: 'Junior (Year 3)',
      email: 'nour.alhuda@jisr.edu',
      phone: '+90 538 672 1940',
      bio: 'UI/UX enthusiast focusing on wireframing and design systems.',
      avatar: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=150',
      skills: ['UI/UX Design', 'Flutter & Dart'],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedFilter = _filters[0];
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _selectedFilter == 'All Topics'
        ? _peers
        : _peers.where((p) => p.skills.contains(_selectedFilter)).toList();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Peers Network',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedFilter,
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down, color: brandColor),
                  items: _filters.map((filter) {
                    return DropdownMenuItem(
                      value: filter,
                      child: Text(
                        filter,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _selectedFilter = val);
                    }
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredList.isEmpty
                ? Center(
                    child: Text(
                      'No peers found for this topic.',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final item = filteredList[index];
                      return Card(
                        elevation: 1,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PeerDetailScreen(peer: item),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  backgroundImage: NetworkImage(item.avatar),
                                  backgroundColor: brandColor.withOpacity(0.1),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        '${item.major} • ${item.year}',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Wrap(
                                        spacing: 6,
                                        children: item.skills.map((skill) {
                                          return Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 3,
                                            ),
                                            decoration: BoxDecoration(
                                              color: brandColor.withOpacity(0.08),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              skill,
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: brandColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class PeerDetailScreen extends StatelessWidget {
  final Peer peer;

  const PeerDetailScreen({super.key, required this.peer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(peer.name),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 46,
              backgroundImage: NetworkImage(peer.avatar),
            ),
            const SizedBox(height: 12),
            Text(
              peer.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              '${peer.major} - ${peer.year}',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Text(
                peer.bio,
                style: const TextStyle(fontSize: 13, height: 1.4),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.email_outlined, color: brandColor),
              title: const Text('Email', style: TextStyle(fontSize: 12, color: Colors.grey)),
              subtitle: Text(peer.email, style: const TextStyle(fontWeight: FontWeight.w600)),
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.phone_outlined, color: brandColor),
              title: const Text('Phone Number', style: TextStyle(fontSize: 12, color: Colors.grey)),
              subtitle: Text(peer.phone, style: const TextStyle(fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(peerName: peer.name),
                    ),
                  );
                },
                icon: const Icon(Icons.chat_bubble_outline),
                label: const Text('Message', style: TextStyle(fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: brandColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isMe;

  _ChatMessage({required this.text, required this.isMe});
}

class ChatScreen extends StatefulWidget {
  final String peerName;

  const ChatScreen({super.key, required this.peerName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<_ChatMessage> _messages = [
    _ChatMessage(text: 'Hey! Saw your profile on Jisr, are you open to collaborate?', isMe: false),
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage(text: text, isMe: true));
    });

    _controller.clear();

    Future.delayed(const Duration(milliseconds: 100), () {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.peerName),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: msg.isMe ? brandColor : Colors.grey[200],
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(12),
                        topRight: const Radius.circular(12),
                        bottomLeft: Radius.circular(msg.isMe ? 12 : 0),
                        bottomRight: Radius.circular(msg.isMe ? 0 : 12),
                      ),
                    ),
                    child: Text(
                      msg.text,
                      style: TextStyle(color: msg.isMe ? Colors.white : Colors.black87),
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.send,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: brandColor,
                    child: IconButton(
                      onPressed: _send,
                      icon: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}