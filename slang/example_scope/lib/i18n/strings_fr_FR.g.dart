///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'package:slang/overrides.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsFrFr implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	/// [AppLocaleUtils.buildWithOverrides] is recommended for overriding.
	TranslationsFrFr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta,})
		: $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.frFr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fr-FR>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsFrFr _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsMainScreenFrFr mainScreen = _TranslationsMainScreenFrFr._(_root);
	@override late final _TranslationsSubScreenFrFr subScreen = _TranslationsSubScreenFrFr._(_root);
	@override Map<String, String> get locales => TranslationOverrides.map(_root.$meta, 'locales') ?? {
		'en': 'Anglais',
		'de': 'Allemand',
		'fr-FR': 'Français',
	};

	@override 
	TranslationsFrFr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsFrFr(meta: meta ?? this.$meta);
}

// Path: mainScreen
class _TranslationsMainScreenFrFr implements TranslationsMainScreenEn {
	_TranslationsMainScreenFrFr._(this._root);

	final TranslationsFrFr _root; // ignore: unused_field

	// Translations
	@override String get title => TranslationOverrides.string(_root.$meta, 'mainScreen.title', {}) ?? 'Le titre français';
	@override String counter({required num n}) => TranslationOverrides.plural(_root.$meta, 'mainScreen.counter', {'n': n}) ?? (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Vous avez appuyé une fois.',
		other: 'Vous avez appuyé ${n} fois.',
	);
	@override String get tapMe => TranslationOverrides.string(_root.$meta, 'mainScreen.tapMe', {}) ?? 'Appuyez-moi';
}

// Path: subScreen
class _TranslationsSubScreenFrFr implements TranslationsSubScreenEn {
	_TranslationsSubScreenFrFr._(this._root);

	final TranslationsFrFr _root; // ignore: unused_field

	// Translations
	@override String get title => TranslationOverrides.string(_root.$meta, 'subScreen.title', {}) ?? 'Deuxième écran';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsFrFr {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'mainScreen.title': return TranslationOverrides.string(_root.$meta, 'mainScreen.title', {}) ?? 'Le titre français';
			case 'mainScreen.counter': return ({required num n}) => TranslationOverrides.plural(_root.$meta, 'mainScreen.counter', {'n': n}) ?? (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
				one: 'Vous avez appuyé une fois.',
				other: 'Vous avez appuyé ${n} fois.',
			);
			case 'mainScreen.tapMe': return TranslationOverrides.string(_root.$meta, 'mainScreen.tapMe', {}) ?? 'Appuyez-moi';
			case 'subScreen.title': return TranslationOverrides.string(_root.$meta, 'subScreen.title', {}) ?? 'Deuxième écran';
			case 'locales.en': return TranslationOverrides.string(_root.$meta, 'locales.en', {}) ?? 'Anglais';
			case 'locales.de': return TranslationOverrides.string(_root.$meta, 'locales.de', {}) ?? 'Allemand';
			case 'locales.fr-FR': return TranslationOverrides.string(_root.$meta, 'locales.fr-FR', {}) ?? 'Français';
			default: return null;
		}
	}
}

