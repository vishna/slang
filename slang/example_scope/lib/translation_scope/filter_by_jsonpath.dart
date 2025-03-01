Map<String, dynamic> filterByJsonPaths(
    Map<String, dynamic> input, Set<String> jsonPaths) {
  Map<String, dynamic> result = {};

  for (String path in jsonPaths) {
    List<String> keys = path.split('.');
    Map<String, dynamic>? currentInput = input;
    Map<String, dynamic> currentResult = result;
    List<Map<String, dynamic>> stack = [result];

    for (int i = 0; i < keys.length; i++) {
      String key = keys[i];

      if (currentInput != null && currentInput.containsKey(key)) {
        if (i == keys.length - 1) {
          currentResult[key] = currentInput[key];
        } else {
          currentResult[key] ??= <String, dynamic>{};
          stack.add(currentResult[key] as Map<String, dynamic>);
          currentInput = currentInput[key] is Map<String, dynamic>
              ? currentInput[key] as Map<String, dynamic>
              : null;
          currentResult = currentResult[key] as Map<String, dynamic>;
        }
      } else {
        break;
      }
    }
  }

  void clean(Map<String, dynamic> map) {
    List<String> keysToRemove = [];

    map.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        clean(value);
        if (value.isEmpty) {
          keysToRemove.add(key);
        }
      }
    });

    for (var key in keysToRemove) {
      map.remove(key);
    }
  }

  clean(result);
  return result;
}
