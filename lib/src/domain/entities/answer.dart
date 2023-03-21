import 'dart:convert';

import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';

abstract class Message {
  bool isUser();
}

class AssistantMessage extends Message {
  final String id;
  final Stream<OpenAIStreamChatCompletionModel> chatStream;
  final MessageMetaData metaData;
  AssistantMessage({
    required this.id,
    required this.chatStream,
    required this.metaData,
  });

  @override
  bool isUser() => false;
}

class UserMessage extends Message {
  final String id;
  final String data;
  final MessageMetaData metaData;
  UserMessage({
    required this.id,
    required this.data,
    required this.metaData,
  });

  @override
  bool isUser() {
    return true;
  }
}

class MessageMetaData {
  final String userId;
  final DateTime createdTime;
  MessageMetaData({
    required this.userId,
    required this.createdTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'createdTime': createdTime.millisecondsSinceEpoch,
    };
  }

  factory MessageMetaData.fromMap(Map<String, dynamic> map) {
    return MessageMetaData(
      userId: map['userId'] ?? '',
      createdTime: DateTime.fromMillisecondsSinceEpoch(map['createdTime']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageMetaData.fromJson(String source) =>
      MessageMetaData.fromMap(json.decode(source));

  @override
  String toString() => 'MetaData(userId: $userId, createdTime: $createdTime)';
}
