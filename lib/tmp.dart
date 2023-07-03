import 'package:flutter/material.dart';

List<String> messages = ['heloooooo', 'hiiii'];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _msgControl = TextEditingController();
  ScrollController _scrollController = ScrollController();
  FocusNode _msgFocusNode = FocusNode();

  @override
  void dispose() {
    _scrollController.dispose();
    _msgControl.dispose();
    _msgFocusNode.dispose();
    super.dispose();
  }

  void _scrollToLatestItem() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Color _getMessageBackgroundColor(String message) {
    final double minLength = 5; // Minimum length for the background shade
    final double maxLength = 20; // Maximum length for the background shade

    final double lengthPercentage = (message.length - minLength) / (maxLength - minLength);
    final int shade = (lengthPercentage * 100).round().clamp(0, 100);

    final color = Colors.blue.shade900.withOpacity(shade / 100); // Adjust the color and opacity as desired

    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final reversedIndex = messages.length - 1 - index;
                final message = messages[reversedIndex];
                final backgroundColor = _getMessageBackgroundColor(message);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    elevation: 1,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        message,
                        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: TextFormField(
                      controller: _msgControl,
                      focusNode: _msgFocusNode,
                      decoration: const InputDecoration(
                        labelText: 'Message',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      messages.add(_msgControl.text);
                      _msgControl.clear();
                      setState(() {});
                      _scrollToLatestItem();
                      FocusScope.of(context).requestFocus(_msgFocusNode);
                    },
                    icon: const Icon(Icons.send),
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
