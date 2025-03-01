import 'dart:convert';

import 'package:example_scope/i18n/strings.g.dart';
import 'package:example_scope/translation_scope/translation_scope_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:slang/generated.dart';
import 'package:slang/overrides.dart';
import 'package:flutter/services.dart' show rootBundle;

class TranslationScope extends HookWidget {
  const TranslationScope({
    super.key,
    this.isEnabled = true,
    required this.child,
  });

  final bool isEnabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final childKey = useMemoized(() => GlobalKey());

    if (!isEnabled) {
      return KeyedSubtree(
        key: childKey,
        child: child,
      );
    }

    final localeData = InheritedLocaleData.of<AppLocale, Translations>(context);

    final translations = localeData.translations;
    final meta = translations.$meta;

    return BlocProvider(
      key: ValueKey(meta.locale),
      create: (_) => TranslationScopeCubit(
        computeOverrides: (contentJson) {
          return AppLocaleUtils.buildWithOverridesSync(
            locale: meta.locale,
            fileType: FileType.json,
            content: jsonEncode(contentJson),
          ).$meta.overrides;
        },
        loadDefaultJson: () async {
          final fileName =
              "${translations.$meta.locale.underscoreTag}.i18n.json";
          return await rootBundle.loadString('lib/i18n/$fileName');
        },
      ),
      child: Builder(
        builder: (context) {
          final cubit = context.watch<TranslationScopeCubit>();
          final metaSpy = _SpyTranslationMetadata(
            locale: meta.locale,
            overrides: cubit.state.updatedScopedOverrides,
            cardinalResolver: meta.cardinalResolver,
            ordinalResolver: meta.ordinalResolver,
            onPathAccessed: (path) {
              cubit.addPath(path);
            },
          );

          return InheritedLocaleData<AppLocale, Translations>(
            translations: translations.$copyWith(meta: metaSpy),
            child: KeyedSubtree(
              key: childKey,
              child: child,
            ),
          );
        },
      ),
    );
  }
}

class _SpyTranslationMetadata
    extends TranslationMetadata<AppLocale, Translations> {
  _SpyTranslationMetadata({
    required super.locale,
    required super.overrides,
    required super.cardinalResolver,
    required super.ordinalResolver,
    required this.onPathAccessed,
  });

  final void Function(String) onPathAccessed;

  @override
  Node? getOverride(String path) {
    onPathAccessed(path);
    return super.getOverride(path);
  }
}
