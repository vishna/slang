import 'package:example_scope/i18n/strings.g.dart';
import 'package:example_scope/translation_scope/translation_scope.dart';
import 'package:example_scope/translation_scope/translation_scope_cubit.dart';
import 'package:example_scope/translation_scope/translation_scope_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale(); // initialize with the right locale
  runApp(TranslationProvider(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: [
        ...GlobalMaterialLocalizations.delegates,
      ],
      home: TranslationScope(child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();

    LocaleSettings.getLocaleStream().listen((event) {
      print('locale changed: $event');
    });
  }

  @override
  Widget build(BuildContext context) {
    // get t variable, will trigger rebuild on locale change
    // otherwise just call t directly (if locale is not changeable)
    final t = Translations.of(context);
    final scopeCubit = context.read<TranslationScopeCubit?>();

    return Scaffold(
      appBar: AppBar(
        title: Text(t.mainScreen.title),
        actions: [
          if (scopeCubit != null)
            IconButton(
                onPressed: () {
                  TranslationScopeEditor.show(context);
                },
                icon: Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TranslationScope(
                      child: SubScreen(),
                    ),
                  ),
                );
              },
              icon: Icon(Icons.navigate_next)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(t.mainScreen.counter(n: _counter)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              // lets loop over all supported locales
              children: AppLocale.values.map((locale) {
                // active locale
                AppLocale activeLocale = LocaleSettings.currentLocale;

                // typed version is preferred to avoid typos
                bool active = activeLocale == locale;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: active ? Colors.blue.shade100 : null,
                    ),
                    onPressed: () {
                      // locale change, will trigger a rebuild (no setState needed)
                      LocaleSettings.setLocale(locale);
                    },
                    child: Text(t.locales[locale.languageTag]!),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() => _counter++);
        },
        tooltip: context.t.mainScreen.tapMe, // using extension method
        child: Icon(Icons.add),
      ),
    );
  }
}

class SubScreen extends StatelessWidget {
  const SubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final scopeCubit = context.read<TranslationScopeCubit?>();

    return Scaffold(
      appBar: AppBar(
        title: Text(t.subScreen.title),
        actions: [
          if (scopeCubit != null)
            IconButton(
                onPressed: () {
                  TranslationScopeEditor.show(context);
                },
                icon: Icon(Icons.edit))
        ],
      ),
      body: Center(
        child: Text(t.locales.values.join(",")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
