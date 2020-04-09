import 'package:url_launcher/url_launcher.dart';
import 'package:linkify/linkify.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

class CallsMessagesEmailUrlService {
  List<Linkifier> _linkifiers = [
    EmailLinkifier(),
    UrlLinkifier(),
    PhoneLinkifier()
  ];

  void call(String number) => launch("tel:$number");
  void sendSms(String number) => launch("sms:$number");
  void sendEmail(String email) => launch("mailto:$email");

  List<Linkifier> get linkifiers => _linkifiers;
}

class EmailLinkifier extends Linkifier {
  const EmailLinkifier();

  @override
  List<LinkifyElement> parse(elements, options) {
    final list = <LinkifyElement>[];

    elements.forEach((element) {
      if (element is TextElement) {
        final match = _emailRegex.firstMatch(element.text);

        if (match == null) {
          list.add(element);
        } else {
          final text = element.text.replaceFirst(match.group(0), '');

          if (match.group(1).isNotEmpty) {
            list.add(TextElement(match.group(1)));
          }

          if (match.group(2).isNotEmpty) {
            // Always humanize emails
            list.add(EmailElement(
              match.group(2).replaceFirst(RegExp(r'mailto:'), ''),
            ));
          }

          if (text.isNotEmpty) {
            list.addAll(parse([TextElement(text)], options));
          }
        }
      } else {
        list.add(element);
      }
    });

    return list;
  }
}

class PhoneLinkifier extends Linkifier {
  const PhoneLinkifier();

  @override
  List<LinkifyElement> parse(elements, options) {
    final list = <LinkifyElement>[];

    elements.forEach((element) {
      if (element is TextElement) {
        final match = _phoneRegex.firstMatch(element.text);

        if (match == null) {
          list.add(element);
        } else {
          final text = element.text.replaceFirst(match.group(0), '');

          if (match.group(1).isNotEmpty) {
            list.add(PhoneElement(match.group(1)));
          }

          if (text.isNotEmpty) {
            list.addAll(parse([TextElement(text)], options));
          }
        }
      } else {
        list.add(element);
      }
    });

    return list;
  }
}

class UrlLinkifier extends Linkifier {
  const UrlLinkifier();

  @override
  List<LinkifyElement> parse(elements, options) {
    final list = <LinkifyElement>[];

    elements.forEach((element) {
      if (element is TextElement) {
        final match = _urlRegex.firstMatch(element.text);

        if (match == null) {
          list.add(element);
        } else {
          final text = element.text.replaceFirst(match.group(0), '');

          if (match.group(1).isNotEmpty) {
            list.add(TextElement(match.group(1)));
          }

          if (match.group(2).isNotEmpty) {
            if (options.humanize ?? false) {
              list.add(UrlElement(
                match.group(2),
                match.group(2).replaceFirst(RegExp(r'https?://'), ''),
              ));
            } else {
              list.add(UrlElement(match.group(2)));
            }
          }

          if (text.isNotEmpty) {
            list.addAll(parse([TextElement(text)], options));
          }
        }
      } else {
        list.add(element);
      }
    });

    return list;
  }
}

/// Represents an element containing a link
class UrlElement extends LinkableElement {
  UrlElement(String url, [String text]) : super(text, url);

  @override
  String toString() {
    return "LinkElement: '$url' ($text)";
  }

  @override
  bool operator ==(other) => equals(other);

  @override
  bool equals(other) => other is UrlElement && super.equals(other);

  @override
  int get hashCode => super.hashCode;

}

/// Represents an element containing a link
class PhoneElement extends LinkableElement {
  PhoneElement(String url, [String text]) : super(text, url);

  @override
  String toString() {
    return "LinkElement: '$url' ($text)";
  }

  @override
  bool operator ==(other) => equals(other);

  @override
  bool equals(other) => other is PhoneElement && super.equals(other);

  @override
  int get hashCode => super.hashCode;

}

/// Represents an element containing an email address
class EmailElement extends LinkableElement {
  final String emailAddress;

  EmailElement(this.emailAddress) : super(emailAddress, 'mailto:$emailAddress');

  @override
  String toString() {
    return "EmailElement: '$emailAddress' ($text)";
  }

  @override
  bool operator ==(other) => equals(other);

  @override
  bool equals(other) =>
      other is EmailElement &&
      super.equals(other) &&
      other.emailAddress == emailAddress;

  @override
  int get hashCode => super.hashCode;

}

final _urlRegex = RegExp(
  r'^((?:.|\n)*?)((?:https?):\/\/[^\s/$.?#].[^\s]*)',
  caseSensitive: false,
);

final _phoneRegex = RegExp(
  r'^((1\s?)?((\([0-9]{3}\))|[0-9]{3})[\s\-]?[\0-9]{3}[\s\-]?[0-9]{4}$)',
  caseSensitive: false,
);

final _emailRegex = RegExp(
  r'^((?:.|\n)*?)((mailto:)?[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4})',
  caseSensitive: false,
);
