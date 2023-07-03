import 'package:flutter/material.dart';

List<String> messages = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _msgControl = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _msgFocusNode = FocusNode();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Chat App'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final reversedIndex = messages.length - 1 - index;
                final message = messages[reversedIndex];
                Color msgBgColor = Colors.blueGrey;
                Color txtColor = Colors.white;
                if (reversedIndex % 2 == 0) {
                  msgBgColor = Colors.blueGrey;
                  txtColor = Colors.white;
                } else {
                  msgBgColor = Colors.white70;
                  txtColor = Colors.black;
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    elevation: 1,
                    color: msgBgColor,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      // Adjust the padding as needed
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 100,
                        style: TextStyle(
                            color: txtColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: TextFormField(
                    focusNode: _msgFocusNode,
                    controller: _msgControl,
                    decoration: const InputDecoration(
                      hintText: 'Write here',
                      hintStyle: TextStyle(
                        color: Colors.green,
                      ),
                      labelText: 'Message',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          borderSide: BorderSide(color: Colors.green)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          borderSide: BorderSide(color: Colors.green)),
                    ),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    color: Colors.blue,
                    onPressed: () {
                      messages.add(_msgControl.text);
                      _msgControl.clear();
                      setState(() {});
                      _scrollToLatestItem();
                      FocusScope.of(context).requestFocus(_msgFocusNode);
                    },
                    icon: const Icon(Icons.send),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
