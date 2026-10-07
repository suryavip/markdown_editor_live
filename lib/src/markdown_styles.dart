import 'package:flutter/material.dart';

/// The text styles used by [MarkdownEditingController] for each markdown
/// element.
///
/// Every parameter is optional. A style that is omitted falls back to the
/// built-in default. A style that is provided *replaces* the default for that
/// element (it is not merged with it), and is then merged on top of the
/// [TextField]'s own style when rendering.
///
/// ```dart
/// MarkdownEditingController(
///   styles: MarkdownStyles(
///     h1: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
///     link: TextStyle(color: Colors.teal),
///   ),
/// );
/// ```
class MarkdownStyles {
  MarkdownStyles({
    TextStyle? h1,
    TextStyle? h2,
    TextStyle? h3,
    TextStyle? h4,
    TextStyle? h5,
    TextStyle? h6,
    TextStyle? bold,
    TextStyle? italic,
    TextStyle? strikethrough,
    TextStyle? inlineCode,
    TextStyle? codeBlock,
    TextStyle? link,
    TextStyle? linkUrl,
    TextStyle? image,
    TextStyle? list,
    TextStyle? listMarker,
    TextStyle? listMarkerFocused,
    TextStyle? thematicBreak,
    TextStyle? imageError,
  }) : h1 = h1 ?? _heading(28),
       h2 = h2 ?? _heading(24),
       h3 = h3 ?? _heading(20),
       h4 = h4 ?? _heading(18),
       h5 = h5 ?? _heading(16),
       h6 = h6 ?? _heading(14),
       bold = bold ?? const TextStyle(fontWeight: FontWeight.bold),
       italic = italic ?? const TextStyle(fontStyle: FontStyle.italic),
       strikethrough =
           strikethrough ??
           const TextStyle(decoration: TextDecoration.lineThrough),
       inlineCode = inlineCode ?? _code(),
       codeBlock = codeBlock ?? _code(),
       link =
           link ??
           const TextStyle(
             color: Colors.blue,
             decoration: TextDecoration.underline,
           ),
       linkUrl = linkUrl ?? TextStyle(color: Colors.blue.shade300),
       image = image ?? const TextStyle(),
       list = list ?? const TextStyle(fontWeight: FontWeight.w500),
       listMarker = listMarker ?? const TextStyle(fontWeight: FontWeight.bold),
       listMarkerFocused =
           listMarkerFocused ?? const TextStyle(color: Colors.blueAccent),
       thematicBreak = thematicBreak ?? const TextStyle(color: Colors.grey),
       imageError =
           imageError ?? const TextStyle(fontSize: 12, color: Colors.grey);

  /// Heading levels 1 to 6 (`#` to `######`).
  final TextStyle h1, h2, h3, h4, h5, h6;

  /// `**bold**` and `__bold__`.
  final TextStyle bold;

  /// `*italic*` and `_italic_`.
  final TextStyle italic;

  /// `~~strikethrough~~`.
  final TextStyle strikethrough;

  /// `` `inline code` ``.
  final TextStyle inlineCode;

  /// Fenced code blocks.
  final TextStyle codeBlock;

  /// The visible text of a `[link](url)`.
  final TextStyle link;

  /// The raw URL of a link or image, shown while its line is being edited.
  final TextStyle linkUrl;

  /// The raw `![alt](url)` syntax of an image, shown while its line is being
  /// edited. Its font size and line height also determine the rendered image
  /// height (see `imageHeightLines`).
  final TextStyle image;

  /// List items (`-`, `*`, `+` and `1.`), merged under [listMarker] and
  /// [listMarkerFocused].
  final TextStyle list;

  /// The rendered bullet or number of a list item.
  final TextStyle listMarker;

  /// The raw bullet or number of a list item while its line is being edited.
  final TextStyle listMarkerFocused;

  /// Thematic breaks (`---`).
  final TextStyle thematicBreak;

  /// The alt-text placeholder shown when an image fails to load.
  final TextStyle imageError;

  /// The style for a heading [level], clamped to 1..6.
  TextStyle headingStyle(int level) {
    switch (level.clamp(1, 6)) {
      case 1:
        return h1;
      case 2:
        return h2;
      case 3:
        return h3;
      case 4:
        return h4;
      case 5:
        return h5;
      default:
        return h6;
    }
  }

  /// Returns a copy with the given styles replaced.
  MarkdownStyles copyWith({
    TextStyle? h1,
    TextStyle? h2,
    TextStyle? h3,
    TextStyle? h4,
    TextStyle? h5,
    TextStyle? h6,
    TextStyle? bold,
    TextStyle? italic,
    TextStyle? strikethrough,
    TextStyle? inlineCode,
    TextStyle? codeBlock,
    TextStyle? link,
    TextStyle? linkUrl,
    TextStyle? image,
    TextStyle? list,
    TextStyle? listMarker,
    TextStyle? listMarkerFocused,
    TextStyle? thematicBreak,
    TextStyle? imageError,
  }) {
    return MarkdownStyles(
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      h3: h3 ?? this.h3,
      h4: h4 ?? this.h4,
      h5: h5 ?? this.h5,
      h6: h6 ?? this.h6,
      bold: bold ?? this.bold,
      italic: italic ?? this.italic,
      strikethrough: strikethrough ?? this.strikethrough,
      inlineCode: inlineCode ?? this.inlineCode,
      codeBlock: codeBlock ?? this.codeBlock,
      link: link ?? this.link,
      linkUrl: linkUrl ?? this.linkUrl,
      image: image ?? this.image,
      list: list ?? this.list,
      listMarker: listMarker ?? this.listMarker,
      listMarkerFocused: listMarkerFocused ?? this.listMarkerFocused,
      thematicBreak: thematicBreak ?? this.thematicBreak,
      imageError: imageError ?? this.imageError,
    );
  }

  static TextStyle _heading(double fontSize) => TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: fontSize,
    color: Colors.blueAccent,
  );

  static TextStyle _code() => TextStyle(
    fontFamily: 'monospace',
    backgroundColor: Colors.grey.shade200.withValues(alpha: 0.5),
  );
}
