import 'package:meta/meta.dart';

@immutable
class Event {
  final String id;
  final String title;
  final String content;
  // final DateTime start;
  final int duration;

  const Event(
      {required this.id,
      required this.title,
      required this.content,
      // required this.start,
      required this.duration});

  factory Event.fromMap(Map<String, dynamic> data, String documentId) {
    final title = data['title'] as String?;
    if (title == null) {
      throw StateError('missing name for jobId: $documentId');
    }
    final content = data['content'] as String?;
    if (content == null) {
      throw StateError('missing name for jobId: $documentId');
    }
    final duration = data['duration'] as int?;
    return Event(
        id: documentId,
        title: title,
        content: content,
        duration: duration ?? 0);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'content': this.content,
      'duration': this.duration,
    };
  }
}
