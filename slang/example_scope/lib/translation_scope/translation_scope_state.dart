import 'package:equatable/equatable.dart';
import 'package:slang/generated.dart';

class TranslationScopeState extends Equatable {
  const TranslationScopeState({
    this.paths = const {},
    this.defaultJson = const {},
    this.scopedJson = const {},
    this.updatedScopedJson = const {},
    this.diffJson = const {},
    this.updatedScopedOverrides = const {},
  });

  // paths used within this scope
  final Set<String> paths;

  final Map<String, dynamic> defaultJson;
  final Map<String, dynamic> scopedJson;
  final Map<String, dynamic> updatedScopedJson;
  final Map<String, dynamic> diffJson;
  final Map<String, Node> updatedScopedOverrides;

  @override
  List<Object?> get props => [
        paths,
        defaultJson,
        scopedJson,
        updatedScopedJson,
        diffJson,
        updatedScopedOverrides,
      ];

  TranslationScopeState copyWith({
    Set<String>? paths,
    Map<String, dynamic>? defaultJson,
    Map<String, dynamic>? scopedJson,
    Map<String, dynamic>? updatedScopedJson,
    Map<String, dynamic>? diffJson,
    Map<String, Node>? updatedScopedOverrides,
  }) =>
      TranslationScopeState(
        paths: paths ?? this.paths,
        defaultJson: defaultJson ?? this.defaultJson,
        scopedJson: scopedJson ?? this.scopedJson,
        updatedScopedJson: updatedScopedJson ?? this.updatedScopedJson,
        diffJson: diffJson ?? this.diffJson,
        updatedScopedOverrides:
            updatedScopedOverrides ?? this.updatedScopedOverrides,
      );
}
