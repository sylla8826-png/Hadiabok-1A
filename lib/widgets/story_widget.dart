import 'package:flutter/material.dart';
import '../models/story_model.dart';
import '../pages/story_viewer_page.dart';

class StoryWidget extends StatelessWidget {
  final Story story;
  final double size;
  const StoryWidget({super.key, required this.story, this.size = 70});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => StoryViewerPage(stories: [story])));
      },
      child: Column(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Colors.purple, Colors.orange]),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(3),
            child: Container(
              decoration: BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
              child: ClipOval(child: Center(child: story.mediaUrl.isNotEmpty ? Image.network(story.mediaUrl, fit: BoxFit.cover, width: size, height: size) : const Icon(Icons.person))),
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(width: size, child: Text(story.authorId, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center)),
        ],
      ),
    );
  }
}