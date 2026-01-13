import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class PersonalMessage extends StatefulWidget {
  final String name;
  final String image;
  const PersonalMessage({super.key, required this.name, required this.image});

  @override
  State<PersonalMessage> createState() => _PersonalMessageState();
}

class _PersonalMessageState extends State<PersonalMessage> with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<ChatMessage> messages = [];
  bool _isRecording = false;
  bool _isTyping = false;
  bool _isBlocked = false;
  late AnimationController _waveController;
  DateTime? _recordingStartTime;

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {
        _isTyping = _textController.text.isNotEmpty;
      });
    });

    _waveController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
  }

  void _sendMessage(String text, {MessageType type = MessageType.text, String? mediaPath}) {
    if (_isBlocked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You have blocked ${widget.name}')),
      );
      return;
    }

    if (text.isNotEmpty || mediaPath != null) {
      setState(() {
        messages.add(ChatMessage(
          text: text,
          isSent: true,
          timestamp: DateTime.now(),
          type: type,
          mediaPath: mediaPath,
        ));
        _textController.clear();
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      _sendMessage('', type: MessageType.image, mediaPath: image.path);
    }
  }

  Future<void> _pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      _sendMessage('', type: MessageType.video, mediaPath: video.path);
    }
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo, color: Colors.purple),
              title: Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt, color: Colors.blue),
              title: Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.videocam, color: Colors.red),
              title: Text('Video'),
              onTap: () {
                Navigator.pop(context);
                _pickVideo();
              },
            ),
            ListTile(
              leading: Icon(Icons.mic, color: Colors.green),
              title: Text('Audio'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Hold mic button to record audio')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                _isBlocked ? Icons.check_circle : Icons.block,
                color: _isBlocked ? Colors.green : Colors.red,
              ),
              title: Text(_isBlocked ? 'Unblock ${widget.name}' : 'Block ${widget.name}'),
              onTap: () {
                setState(() {
                  _isBlocked = !_isBlocked;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(_isBlocked
                        ? '${widget.name} has been blocked'
                        : '${widget.name} has been unblocked'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text('Clear Chat'),
              onTap: () {
                setState(() {
                  messages.clear();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.report, color: Colors.orange),
              title: Text('Report'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Report feature')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _makeVoiceCall() {
    if (_isBlocked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unblock ${widget.name} to make calls')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Voice call to ${widget.name}')),
    );
  }

  void _makeVideoCall() {
    if (_isBlocked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unblock ${widget.name} to make calls')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Video call to ${widget.name}')),
    );
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _recordingStartTime = DateTime.now();
    });
    _waveController.repeat();
  }

  void _stopRecording() {
    if (!_isRecording) return;

    _waveController.stop();

    final duration = DateTime.now().difference(_recordingStartTime!);

    setState(() {
      _isRecording = false;
    });

    // Audio message send করা হচ্ছে
    _sendMessage(
      'Audio ${duration.inSeconds}s',
      type: MessageType.audio,
      mediaPath: 'audio_${DateTime.now().millisecondsSinceEpoch}.m4a',
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Audio sent (${duration.inSeconds}s)'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundImage: AssetImage(widget.image),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name, style: TextStyle(fontSize: 16)),
                Text(
                  _isBlocked ? 'Blocked' : 'Online',
                  style: TextStyle(
                    fontSize: 12,
                    color: _isBlocked ? Colors.red : Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.phone, color: Colors.green),
            onPressed: _makeVoiceCall,
          ),
          IconButton(
            icon: Icon(Icons.videocam, color: Colors.red),
            onPressed: _makeVideoCall,
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: _showMoreOptions,
          ),
        ],
      ),
      body: Column(
        children: [
          if (_isBlocked)
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.red.shade100,
              child: Row(
                children: [
                  Icon(Icons.block, color: Colors.red, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'You have blocked ${widget.name}. Unblock to send messages.',
                      style: TextStyle(color: Colors.red.shade900),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: messages.isEmpty
                ? Center(
              child: Text(
                'No messages yet\nSay hi to ${widget.name}!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            )
                : ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(15),
              itemCount: messages.length,
              itemBuilder: (_, index) {
                final message = messages[messages.length - 1 - index];
                return MessageBubble(message: message);
              },
            ),
          ),

          // Recording UI
          if (_isRecording)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              color: isDark ? Colors.grey[850] : Colors.red.shade50,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.mic, color: Colors.white, size: 24),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Recording...',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(height: 5),
                        AnimatedBuilder(
                          animation: _waveController,
                          builder: (context, child) {
                            return CustomPaint(
                              painter: WaveformPainter(
                                animation: _waveController.value,
                                isDark: isDark,
                              ),
                              size: Size(double.infinity, 40),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  StreamBuilder(
                    stream: Stream.periodic(Duration(seconds: 1)),
                    builder: (context, snapshot) {
                      if (_recordingStartTime == null) return SizedBox();
                      final duration = DateTime.now().difference(_recordingStartTime!);
                      return Text(
                        '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

          // Input area
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[900] : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 5,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                if (!_isRecording)
                  IconButton(
                    icon: Icon(
                      Icons.attach_file,
                      color: isDark ? Colors.grey[400] : Colors.grey[700],
                    ),
                    onPressed: _isBlocked ? null : _showAttachmentOptions,
                  ),
                if (!_isRecording)
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[800] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextField(
                        controller: _textController,
                        enabled: !_isBlocked,
                        decoration: InputDecoration(
                          hintText: _isBlocked ? "Blocked" : "Type a message",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                        ),
                        maxLines: null,
                      ),
                    ),
                  ),
                if (_isRecording)
                  Expanded(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.keyboard_arrow_left, color: Colors.grey),
                          Text(
                            'Slide to cancel',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                SizedBox(width: 5),

                // Send/Mic button with gesture
                GestureDetector(
                  onLongPress: () {
                    if (!_isTyping && !_isBlocked) {
                      _startRecording();
                    }
                  },
                  onLongPressEnd: (_) {
                    if (_isRecording) {
                      _stopRecording();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isRecording ? Colors.red : Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        _isTyping ? Icons.send : Icons.mic,
                        color: Colors.white,
                      ),
                      onPressed: _isBlocked
                          ? null
                          : () {
                        if (_isTyping) {
                          _sendMessage(_textController.text);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Waveform Painter for recording animation
class WaveformPainter extends CustomPainter {
  final double animation;
  final bool isDark;

  WaveformPainter({required this.animation, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDark ? Colors.blue : Colors.red
      ..strokeWidth = 3
      ..style = PaintingStyle.fill;

    final barCount = 30;
    final barWidth = size.width / barCount;

    for (int i = 0; i < barCount; i++) {
      final x = i * barWidth;
      final heightFactor = (i / barCount + animation) % 1.0;
      final height = size.height * (0.3 + 0.5 * heightFactor);

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x + barWidth * 0.2, (size.height - height) / 2, barWidth * 0.6, height),
          Radius.circular(4),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(WaveformPainter oldDelegate) => true;
}

enum MessageType { text, image, video, audio }

class ChatMessage {
  final String text;
  final bool isSent;
  final DateTime timestamp;
  final MessageType type;
  final String? mediaPath;

  ChatMessage({
    required this.text,
    required this.isSent,
    required this.timestamp,
    this.type = MessageType.text,
    this.mediaPath,
  });
}

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Align(
      alignment: message.isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        decoration: BoxDecoration(
          color: message.isSent
              ? Colors.blue
              : (isDark ? Colors.grey[800] : Colors.grey[300]),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.type == MessageType.image && message.mediaPath != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(message.mediaPath!),
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              )
            else if (message.type == MessageType.video)
              Container(
                padding: EdgeInsets.all(20),
                child: Icon(Icons.play_circle_fill, size: 50, color: Colors.white),
              )
            else if (message.type == MessageType.audio)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: message.isSent
                            ? Colors.white.withOpacity(0.3)
                            : Colors.blue.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: message.isSent ? Colors.white : (isDark ? Colors.white : Colors.black),
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                            child: CustomPaint(
                              painter: AudioWavePainter(
                                color: message.isSent
                                    ? Colors.white
                                    : (isDark ? Colors.white : Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            message.text,
                            style: TextStyle(
                              color: message.isSent ? Colors.white : (isDark ? Colors.white : Colors.black),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              else
                Text(
                  message.text,
                  style: TextStyle(
                    color: message.isSent ? Colors.white : (isDark ? Colors.white : Colors.black),
                  ),
                ),
            SizedBox(height: 5),
            Text(
              '${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}',
              style: TextStyle(
                fontSize: 10,
                color: message.isSent
                    ? Colors.white70
                    : (isDark ? Colors.grey[400] : Colors.grey[600]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Audio wave painter for message bubble
class AudioWavePainter extends CustomPainter {
  final Color color;

  AudioWavePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.7)
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final barCount = 20;
    final barWidth = size.width / barCount;

    for (int i = 0; i < barCount; i++) {
      final x = i * barWidth;
      final heightFactor = (i % 3 == 0) ? 0.8 : (i % 2 == 0 ? 0.5 : 0.3);
      final height = size.height * heightFactor;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, (size.height - height) / 2, barWidth * 0.6, height),
          Radius.circular(2),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(AudioWavePainter oldDelegate) => false;
}