// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:example_scope/translation_scope/filter_by_jsonpath.dart';
import 'package:test/test.dart';

void main() {
  final deepEquality = DeepCollectionEquality();

  test('filterByPaths extracts correct fields', () {
    // given
    Map<String, dynamic> input = {
      'field1': {
        'subfield1': 42,
        'subfield2': {'field3': 'hello'}
      },
      'field2': 'world'
    };
    List<String> jsonPaths = ['field1.subfield2.field3', 'field2'];

    // when
    final filteredInput = filterByJsonPaths(input, jsonPaths.toSet());

    // then
    Map<String, dynamic> expectedOutput = {
      'field1': {
        'subfield2': {'field3': 'hello'}
      },
      'field2': 'world'
    };

    expect(deepEquality.equals(filteredInput, expectedOutput), isTrue);
  });

  test('filterByPaths returns empty map when no matching paths', () {
    Map<String, dynamic> input = {
      'field1': {'subfield1': 42}
    };

    List<String> jsonPaths = ['field2'];

    expect(deepEquality.equals(filterByJsonPaths(input, jsonPaths.toSet()), {}),
        isTrue);
  });

  test('filterByPaths handles nested missing fields', () {
    // given
    Map<String, dynamic> input = {
      'field1': {'subfield1': 42}
    };
    List<String> jsonPaths = ['field1.subfield2'];

    // when
    final filteredInput = filterByJsonPaths(input, jsonPaths.toSet());

    // then
    expect(deepEquality.equals(filteredInput, {}), isTrue);
  });
}
