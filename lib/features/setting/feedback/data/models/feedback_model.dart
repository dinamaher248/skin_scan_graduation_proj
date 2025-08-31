class FeedbackModel {
  final String subject;
  final String feedback;

  FeedbackModel({required this.subject, required this.feedback});

  Map<String, dynamic> toJson() {
    return {
      'Subject': subject,
      'FeedBackContent': feedback,
    };
  }
}
