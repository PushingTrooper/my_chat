import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chats/zhr0k1o6KUZZyDfqeoU7/messages")
            .snapshots(),
        builder: (ctx, latestSnapshot) {
          if (!latestSnapshot.hasData) {
            return const Text('Is Loading');
          }
          var documents = (latestSnapshot.data as QuerySnapshot).docs;

          return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (ctx, index) => Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(documents[index].get('text')),
                  ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/zhr0k1o6KUZZyDfqeoU7/messages')
              .add({'text': 'This was added by clicking the button'});
        },
      ),
    );
  }
}
