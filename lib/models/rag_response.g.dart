
part of 'rag_response.dart';


RagResponse _$RagResponseFromJson(Map<String, dynamic> json) => RagResponse(
      answer: json['answer'] as String,
    );

Map<String, dynamic> _$RagResponseToJson(RagResponse instance) =>
    <String, dynamic>{
      'answer': instance.answer,
    };
