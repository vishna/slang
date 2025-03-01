import 'dart:convert';

import 'package:example_scope/translation_scope/translation_scope_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:json_editor_flutter/json_editor_flutter.dart';

class TranslationScopeEditor extends HookWidget {
  const TranslationScopeEditor({super.key});

  static void show(BuildContext context) {
    final scopeCubit = context.read<TranslationScopeCubit?>();
    if (scopeCubit == null) {
      return;
    }

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BlocProvider.value(
            value: scopeCubit,
            child: TranslationScopeEditor(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<TranslationScopeCubit>();
    final state = cubit.state;
    final jsonString = useMemoized(
        () => jsonEncode(state.updatedScopedJson.isNotEmpty
            ? state.updatedScopedJson
            : state.scopedJson),
        [state.defaultJson]);

    final expandedObjects = useMemoized(
        () => [for (final path in state.paths) path.split(".").toList()],
        [state.paths]);

    return Material(
      child: JsonEditor(
        enableKeyEdit: false,
        enableMoreOptions: false,
        hideEditorsMenuButton: true,
        expandedObjects: expandedObjects,
        onChanged: (value) {
          cubit.updateJson(value);
        },
        json: jsonString,
      ),
    );
  }
}
