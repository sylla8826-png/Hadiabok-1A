import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/post_model.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _textController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _image;
  bool _loading = false;

  Future<void> _pickImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked != null) {
      setState(() => _image = File(picked.path));
    }
  }

  Future<void> _submit() async {
    if (_textController.text.trim().isEmpty && _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ajouter du texte ou une image')));
      return;
    }
    setState(() => _loading = true);
    // TODO: uploader l'image vers Storage et créer un Post dans Firestore
    await Future.delayed(const Duration(seconds: 1));
    final newPost = Post(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      authorId: 'demo-user-id',
      content: _textController.text.trim(),
      mediaUrls: _image != null ? ['local:${_image!.path}'] : const [],
    );
    // TODO: send newPost to backend
    setState(() => _loading = false);
    Navigator.pop(context, newPost);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un post'),
        actions: [
          TextButton(
            onPressed: _loading ? null : _submit,
            child: _loading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Publier', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              maxLines: 5,
              decoration: const InputDecoration(hintText: 'Quoi de neuf ?', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            if (_image != null)
              Stack(
                children: [
                  Image.file(_image!, height: 200, width: double.infinity, fit: BoxFit.cover),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => setState(() => _image = null),
                    ),
                  )
                ],
              ),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.photo),
                  label: const Text('Image'),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: ajouter option story / groupe / visibilité
                  },
                  icon: const Icon(Icons.group),
                  label: const Text('Visibilité'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}