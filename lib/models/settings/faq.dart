class Faq {
  final String question;
  final String answer;

  const Faq({
    required this.question,
    required this.answer,
  });

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answer': answer,
    };
  }

  factory Faq.fromMap(Map<String, dynamic> map) {
    return Faq(
      question: map['question'] ?? '',
      answer: map['answer'] ?? '',
    );
  }
}
