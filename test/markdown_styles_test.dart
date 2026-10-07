import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markdown_editor_live/markdown_editor_live.dart';

/// Finds the style of the first span whose text equals [text].
TextStyle? _styleOf(InlineSpan root, String text) {
  TextStyle? found;
  root.visitChildren((span) {
    if (span is TextSpan && span.text == text) {
      found = span.style;
      return false;
    }
    return true;
  });
  return found;
}

void main() {
  Future<TextSpan> build(
    WidgetTester tester,
    MarkdownEditingController controller,
  ) async {
    late TextSpan span;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            span = controller.buildTextSpan(
              context: context,
              withComposing: false,
            );
            return const SizedBox();
          },
        ),
      ),
    );
    return span;
  }

  group('MarkdownStyles', () {
    test('headingStyle clamps level to 1..6', () {
      final styles = MarkdownStyles(h1: const TextStyle(fontSize: 1));
      expect(styles.headingStyle(0), same(styles.h1));
      expect(styles.headingStyle(1), same(styles.h1));
      expect(styles.headingStyle(6), same(styles.h6));
      expect(styles.headingStyle(9), same(styles.h6));
    });

    test('copyWith keeps unspecified styles', () {
      final original = MarkdownStyles(bold: const TextStyle(fontSize: 3));
      final copy = original.copyWith(italic: const TextStyle(fontSize: 4));
      expect(copy.bold, same(original.bold));
      expect(copy.italic.fontSize, 4);
    });

    testWidgets('custom styles are applied', (tester) async {
      final controller = MarkdownEditingController(
        text: '# Title\n\n**b** and [t](http://x)',
        styles: MarkdownStyles(
          h1: const TextStyle(fontSize: 40, color: Colors.red),
          bold: const TextStyle(fontWeight: FontWeight.w900),
          link: const TextStyle(color: Colors.green),
        ),
      );
      final span = await build(tester, controller);

      expect(_styleOf(span, 'Title')?.fontSize, 40);
      expect(_styleOf(span, 'Title')?.color, Colors.red);
      expect(_styleOf(span, 'b')?.fontWeight, FontWeight.w900);
      expect(_styleOf(span, 't')?.color, Colors.green);
    });

    testWidgets('default styles are used when none given', (tester) async {
      final controller = MarkdownEditingController(text: '# Title');
      final span = await build(tester, controller);
      expect(_styleOf(span, 'Title')?.fontSize, 28);
    });

    testWidgets('setting styles notifies listeners', (tester) async {
      final controller = MarkdownEditingController(text: '# Title');
      var notified = 0;
      controller.addListener(() => notified++);

      controller.styles = MarkdownStyles(h1: const TextStyle(fontSize: 50));
      expect(notified, 1);

      final span = await build(tester, controller);
      expect(_styleOf(span, 'Title')?.fontSize, 50);
    });
  });
}
