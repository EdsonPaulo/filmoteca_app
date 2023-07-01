import 'package:flutter/material.dart';

class CommentTab extends StatefulWidget {
  const CommentTab({super.key});

  @override
  _CommentTab createState() => _CommentTab();
}

class _CommentTab extends State<CommentTab> {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Comentários 12',
      style: TextStyle(color: Colors.white),
    );
  }
}
