import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../services/video_service.dart';

class UploadVideoScreen extends StatefulWidget {
  const UploadVideoScreen({super.key});

  @override
  UploadVideoScreenState createState() => UploadVideoScreenState();
}

class UploadVideoScreenState extends State<UploadVideoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _videoFile;
  bool _isUploading = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _videoFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadVideo() async {
    if (!_formKey.currentState!.validate() || _videoFile == null) return;

    setState(() {
      _isUploading = true;
    });

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final videoService = VideoService();

    final response = await videoService.uploadVideo(
      _titleController.text.trim(),
      _descriptionController.text.trim(),
      _videoFile!,
      userProvider.token ?? '',
    );

    if (!mounted) return;

    setState(() {
      _isUploading = false;
    });

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Video uploaded successfully')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to upload video')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Video'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (_videoFile != null)
                const SizedBox(
                  height: 200,
                  child: Center(
                    child: Text(
                      'Video selected: \${_videoFile!.path.split(Platform.pathSeparator).last}',
                    ),
                  ),
                )
              else
                Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Center(child: Text('No video selected')),
                ),
              ElevatedButton(
                onPressed: _pickVideo,
                child: const Text('Select Video'),
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              _isUploading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _uploadVideo,
                      child: const Text('Upload'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
