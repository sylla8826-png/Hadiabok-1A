import 'dart:async';
import 'package:flutter/material.dart';
import '../models/story_model.dart';

class StoryViewerPage extends StatefulWidget {
  final List<Story> stories;
  final int initialIndex;

  const StoryViewerPage({super.key, required this.stories, this.initialIndex = 0});

  @override
  State<StoryViewerPage> createState() => _StoryViewerPageState();
}

class _StoryViewerPageState extends State<StoryViewerPage> {
  late PageController _controller;
  Timer? _timer;
  int _current = 0;

  void _startTimer() {
    _timer?.cancel();
    final duration = Duration(seconds: widget.stories[_current].durationSeconds);
    _timer = Timer(duration, () {
      if (_current < widget.stories.length - 1) {
        _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      } else {
        Navigator.pop(context);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _current = widget.initialIndex;
    _controller = PageController(initialPage: widget.initialIndex);
    WidgetsBinding.instance.addPostFrameCallback((_) => _startTimer());
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (details) {
          final w = MediaQuery.of(context).size.width;
          if (details.globalPosition.dx < w * 0.3) {
            if (_current > 0) _controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
          } else {
            if (_current < widget.stories.length - 1) _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
            else Navigator.pop(context);
          }
        },
        child: SafeArea(
          child: Stack(
            children: [
              PageView.builder(
                controller: _controller,
                itemCount: widget.stories.length,
                onPageChanged: (i) {
                  setState(() => _current = i);
                  _startTimer();
                },
                itemBuilder: (context, index) {
                  final s = widget.stories[index];
                  return Center(
                    child: s.mediaUrl.endsWith('.mp4')
                        ? const Text('Vidéo - à implémenter', style: TextStyle(color: Colors.white))
                        : Image.network(s.mediaUrl, fit: BoxFit.contain),
                  );
                },
              ),
              Positioned(
                top: 8,
                left: 8,
                right: 8,
                child: Row(
                  children: widget.stories.map((e) {
                    final idx = widget.stories.indexOf(e);
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: LinearProgressIndicator(
                          value: idx < _current ? 1 : (idx == _current ? null : 0),
                          backgroundColor: Colors.white24,
                          color: Colors.white,
                          minHeight: 3,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Row(
                  children: [
                    const CircleAvatar(child: Icon(Icons.person)),
                    const SizedBox(width: 8),
                    Text(widget.stories[_current].authorId, style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}