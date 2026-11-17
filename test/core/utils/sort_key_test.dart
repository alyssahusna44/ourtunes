import 'package:flutter_test/flutter_test.dart';

import 'package:ourtunes/core/utils/sort_key.dart';

void main() {
  group('buildSortKey', () {
    test('returns null for null, empty and blank input', () {
      expect(buildSortKey(null), isNull);
      expect(buildSortKey(''), isNull);
      expect(buildSortKey('   '), isNull);
    });

    test('is case-insensitive and trims whitespace', () {
      expect(buildSortKey('  ADELE  '), 'adele');
      expect(buildSortKey('Daft   Punk'), 'daft punk');
    });

    test('ignores a leading article', () {
      expect(buildSortKey('The Beatles'), 'beatles');
      expect(buildSortKey('A Tribe Called Quest'), 'tribe called quest');
      expect(buildSortKey('An Example'), 'example');
    });

    test('keeps articles that are not leading or are the whole value', () {
      expect(buildSortKey('Hotel California'), 'hotel california');
      expect(buildSortKey('Another One'), 'another one');
      expect(buildSortKey('The'), 'the');
      expect(buildSortKey('A'), 'a');
    });
  });
}
