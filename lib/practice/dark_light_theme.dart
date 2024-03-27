import 'package:flutter/material.dart';

void main() {
  runApp(MyThemePage());
}

class MyThemePage extends StatelessWidget {
  final ValueNotifier<ThemeMode> notifier = ValueNotifier(ThemeMode.light);
  MyThemePage({super.key});

  final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
      background: Colors.white,
      primary: Colors.black,
      secondary: Colors.blue,
    ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.blue,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black,fontSize: 20),
      bodySmall: TextStyle(color: Colors.black,fontSize:12),
    ),
  );

  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.white,
    colorScheme: ColorScheme.dark(
      background: Colors.black,
      primary: Colors.white,
      secondary: Colors.grey,
    ),
    textTheme: const TextTheme(
       bodyMedium: TextStyle(color: Colors.white,fontSize: 20),
      bodySmall: TextStyle(color: Colors.white,fontSize: 12),
     
    ),
    
  );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (BuildContext context, ThemeMode mode, Widget? child) {
        return MaterialApp(
          themeMode: mode,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: ApplyDarkMode(notifier: notifier),
        );
      },
    );
  }
}

class ApplyDarkMode extends StatefulWidget {
  final ValueNotifier<ThemeMode> notifier;
  const ApplyDarkMode({Key? key, required this.notifier}) : super(key: key);

  @override
  State<ApplyDarkMode> createState() => _ApplyDarkModeState();
}

class _ApplyDarkModeState extends State<ApplyDarkMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Container(
          height: 200,
          width: 300,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,

          ),
          child: Row(
            children: [
              Text("Here is Text Style",style: Theme.of(context).textTheme.bodyMedium,),
              ElevatedButton(
                onPressed: () {
                  widget.notifier.value = widget.notifier.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
                },
                child: Text("Change",style: Theme.of(context).textTheme.bodySmall,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}