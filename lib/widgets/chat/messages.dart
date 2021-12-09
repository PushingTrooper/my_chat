import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../chat/message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.data != null) {
            final documents = (snapshot.data as QuerySnapshot).docs;

            return ListView.builder(
              reverse: true,
              itemCount: documents.length,
              itemBuilder: (context, index) => MessageBubble(
                documents[index].get('text'),
                documents[index].get('userId') ==
                    (FirebaseAuth.instance.currentUser?.uid ?? ""),
                key: ValueKey(
                  documents[index].id,
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
      },
    );
  }
}
