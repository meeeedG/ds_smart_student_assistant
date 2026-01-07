
part of 'chat_request.dart';


ChatRequest _$ChatRequestFromJson(Map<String, dynamic> json) => ChatRequest(
      question: json['question'] as String,
    );

Map<String, dynamic> _$ChatRequestToJson(ChatRequest instance) =>
    <String, dynamic>{
      'question': instance.question,
    };
