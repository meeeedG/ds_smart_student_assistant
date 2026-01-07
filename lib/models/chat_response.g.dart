
part of 'chat_response.dart';


ChatResponse _$ChatResponseFromJson(Map<String, dynamic> json) => ChatResponse(
      answer: json['answer'] as String,
    );

Map<String, dynamic> _$ChatResponseToJson(ChatResponse instance) =>
    <String, dynamic>{
      'answer': instance.answer,
    };
