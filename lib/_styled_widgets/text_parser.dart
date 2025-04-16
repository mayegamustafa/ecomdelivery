import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';

class TextParser extends StatelessWidget {
  const TextParser({
    super.key,
    required this.text,
    this.style,
  });

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final tStyle = style ?? context.textTheme.bodyLarge;
    return ParsedText(
      text: text,
      style: tStyle,
      parse: [
        MatchText(
          type: ParsedType.PHONE,
          onTap: (x) => URLHelper.call(x),
        ),
        MatchText(
          type: ParsedType.EMAIL,
          onTap: (x) => URLHelper.mail(x),
        ),
        MatchText(
          type: ParsedType.URL,
          onTap: (x) => URLHelper.url(x),
        ),
      ],
    );
  }
}
