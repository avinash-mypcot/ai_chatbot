class ChatModel {
  final List<Candidates>? candidates;
  final UsageMetadata? usageMetadata;
  final String? modelVersion;

  ChatModel({
    this.candidates,
    this.usageMetadata,
    this.modelVersion,
  });

  ChatModel copyWith({
    List<Candidates>? candidates,
    UsageMetadata? usageMetadata,
    String? modelVersion,
  }) {
    return ChatModel(
      candidates: candidates ?? this.candidates,
      usageMetadata: usageMetadata ?? this.usageMetadata,
      modelVersion: modelVersion ?? this.modelVersion,
    );
  }

  ChatModel.fromJson(Map<String, dynamic> json)
      : candidates = (json['candidates'] as List?)
            ?.map((dynamic e) => Candidates.fromJson(e as Map<String, dynamic>))
            .toList(),
        usageMetadata = (json['usageMetadata'] as Map<String, dynamic>?) != null
            ? UsageMetadata.fromJson(
                json['usageMetadata'] as Map<String, dynamic>)
            : null,
        modelVersion = json['modelVersion'] as String?;

  Map<String, dynamic> toJson() => {
        'candidates': candidates?.map((e) => e.toJson()).toList(),
        'usageMetadata': usageMetadata?.toJson(),
        'modelVersion': modelVersion
      };
}

class Candidates {
  final Content? content;
  final String? finishReason;
  final double? avgLogprobs;

  Candidates({
    this.content,
    this.finishReason,
    this.avgLogprobs,
  });

  Candidates copyWith({
    Content? content,
    String? finishReason,
    double? avgLogprobs,
  }) {
    return Candidates(
      content: content ?? this.content,
      finishReason: finishReason ?? this.finishReason,
      avgLogprobs: avgLogprobs ?? this.avgLogprobs,
    );
  }

  Candidates.fromJson(Map<String, dynamic> json)
      : content = (json['content'] as Map<String, dynamic>?) != null
            ? Content.fromJson(json['content'] as Map<String, dynamic>)
            : null,
        finishReason = json['finishReason'] as String?,
        avgLogprobs = json['avgLogprobs'] as double?;

  Map<String, dynamic> toJson() => {
        'content': content?.toJson(),
        'finishReason': finishReason,
        'avgLogprobs': avgLogprobs
      };
}

class Content {
  final List<Parts>? parts;
  final String? role;

  Content({
    this.parts,
    this.role,
  });

  Content copyWith({
    List<Parts>? parts,
    String? role,
  }) {
    return Content(
      parts: parts ?? this.parts,
      role: role ?? this.role,
    );
  }

  Content.fromJson(Map<String, dynamic> json)
      : parts = (json['parts'] as List?)
            ?.map((dynamic e) => Parts.fromJson(e as Map<String, dynamic>))
            .toList(),
        role = json['role'] as String?;

  Map<String, dynamic> toJson() =>
      {'parts': parts?.map((e) => e.toJson()).toList(), 'role': role};
}

class Parts {
  final String? text;
  final bool? isUser;

  Parts({
    this.text,
    this.isUser,
  });

  Parts copyWith({
    String? text,
    bool? isUser,
  }) {
    return Parts(
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
    );
  }

  Parts.fromJson(Map<String, dynamic> json)
      : text = json['text'] as String?,
        isUser = json['isUser'] as bool?;

  Map<String, dynamic> toJson() => {'text': text, 'isUser': isUser};
}

class UsageMetadata {
  final int? promptTokenCount;
  final int? candidatesTokenCount;
  final int? totalTokenCount;

  UsageMetadata({
    this.promptTokenCount,
    this.candidatesTokenCount,
    this.totalTokenCount,
  });

  UsageMetadata copyWith({
    int? promptTokenCount,
    int? candidatesTokenCount,
    int? totalTokenCount,
  }) {
    return UsageMetadata(
      promptTokenCount: promptTokenCount ?? this.promptTokenCount,
      candidatesTokenCount: candidatesTokenCount ?? this.candidatesTokenCount,
      totalTokenCount: totalTokenCount ?? this.totalTokenCount,
    );
  }

  UsageMetadata.fromJson(Map<String, dynamic> json)
      : promptTokenCount = json['promptTokenCount'] as int?,
        candidatesTokenCount = json['candidatesTokenCount'] as int?,
        totalTokenCount = json['totalTokenCount'] as int?;

  Map<String, dynamic> toJson() => {
        'promptTokenCount': promptTokenCount,
        'candidatesTokenCount': candidatesTokenCount,
        'totalTokenCount': totalTokenCount
      };
}
