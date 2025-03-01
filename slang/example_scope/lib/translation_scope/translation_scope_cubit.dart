import 'dart:convert';

import 'package:example_scope/translation_scope/filter_by_jsonpath.dart';
import 'package:example_scope/translation_scope/translation_scope_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsoft_diff_patch/fsoft_diff_patch.dart';
import 'package:slang/generated.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

typedef TranslationScopeCubitComputeOverrides = Map<String, Node> Function(
    Map<String, dynamic>);
typedef TranslationScopeCubitLoadDefaultJson = Future<String> Function();

class TranslationScopeCubit extends Cubit<TranslationScopeState> {
  TranslationScopeCubit({
    required this.computeOverrides,
    required this.loadDefaultJson,
  }) : super(TranslationScopeState()) {
    loadDefaultJson().then((defaultJson) {
      emit(state.copyWith(defaultJson: jsonDecode(defaultJson)));
    });
  }

  final TranslationScopeCubitComputeOverrides computeOverrides;
  final TranslationScopeCubitLoadDefaultJson loadDefaultJson;

  /// add path encountered while rendering a widget
  addPath(String path) {
    emit(
      state.copyWith(
        paths: {
          ...state.paths,
          path,
        },
      ),
    );
  }

  /// diff json
  void updateJson(Map<String, dynamic> updatedJson) {
    final delta = diff(state.scopedJson, updatedJson);
    emit(
      state.copyWith(
        diffJson: delta,
        updatedScopedJson: updatedJson,
        updatedScopedOverrides: computeOverrides(updatedJson),
      ),
    );
  }

  @override
  void emit(TranslationScopeState state) {
    final paths = _recomputePaths(state).toSet();
    final defaultJson = state.defaultJson;
    final scopedJson = filterByJsonPaths(defaultJson, paths);

    super.emit(state.copyWith(
      scopedJson: scopedJson,
      paths: paths,
    ));
  }
}

// paths are sometimes something(map) / something(array) etc.
List<String> _recomputePaths(TranslationScopeState state) {
  final paths = state.paths;
  final correctPaths = <String>[];
  for (final path in paths) {
    final pathParts = path.split(".");
    dynamic it = state.defaultJson;
    final outputPath = <String>[];
    for (var index = 0; index < pathParts.length; index++) {
      final pathPart = pathParts[index];
      final nextIt = it[pathPart];
      outputPath.add(pathPart);
      if (nextIt == null) {
        if (it is Map<String, dynamic> && index + 1 == pathParts.length) {
          final actualPathPart =
              it.keys.firstWhereOrNull((key) => key.startsWith("$pathPart"));
          if (actualPathPart != null) {
            outputPath[outputPath.length - 1] = actualPathPart;
          }
        }
      } else {
        it = nextIt;
      }
    }
    correctPaths.add(outputPath.join("."));
  }
  return correctPaths;
}
