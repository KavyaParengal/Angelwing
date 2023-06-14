import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          leadingWidth: 30,
          title: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(23),
                child: Image.asset(
                    'image/orphanages.webp',
                  width: 45,
                  height: 45,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
