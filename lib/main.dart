import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sort_speed/logic/sort.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange[900]!),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Sort Speed'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> genArray = [];
  bool isTap = false;
  List<int> sortBubble = [];
  List<int> sortMerge = [];
  List<int> sortShell = [];
  dynamic bubbleTime;
  dynamic mergeTime;
  dynamic shellTime;
  Stopwatch stopWatch = Stopwatch();
  @override
  Widget build(BuildContext context) {
    TextEditingController lenghtController = TextEditingController();
    var titleStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.deepOrange[900]!,
    );
    var numberStyle = TextStyle(fontSize: 20, color: Colors.deepOrange[900]);
    const titlePadding = EdgeInsets.only(top: 30, bottom: 10, left: 10);
    const textPadding = EdgeInsets.symmetric(horizontal: 10);
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[900],
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.orange[50],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Text('Generate an array of your chosen length and observe the performance of the sort function.',
                  style: titleStyle),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    child: TextFormField(
                      maxLength: 4,
                      controller: lenghtController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Array length',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.deepOrange[600]!,
                          ),
                        ),
                      ),
                      inputFormatters: [
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          final pattern = RegExp(r'^[0-9]+$');
                          if (pattern.hasMatch(newValue.text) || newValue.text.isEmpty) {
                            return newValue;
                          }
                          return oldValue;
                        }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 20),
                    child: Align(
                        alignment: Alignment.center,
                        child: Button(
                          text: 'Generate',
                          onPressed: () {
                            if (lenghtController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Please enter a number'),
                                  backgroundColor: Colors.red[900],
                                ),
                              );
                              return;
                            }
                            setState(() {
                              genArray = _generateArray(int.parse(lenghtController.text));
                            });
                          },
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 55),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Visibility(
                  visible: genArray.isNotEmpty,
                  child: Text(
                    'Generated Array:',
                    style: titleStyle,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Visibility(
                visible: genArray.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isTap = !isTap;
                      });
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 238, 211),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            genArray.toString(),
                            style: numberStyle,
                            maxLines: isTap ? null : 2,
                            overflow: isTap ? null : TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: genArray.isNotEmpty,
              child: Button(
                text: 'Sortieren',
                onPressed: () {
                  if (genArray.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Please generate an array first'),
                        backgroundColor: Colors.red[900],
                      ),
                    );
                    return;
                  }

                  setState(() {
                    stopWatch.start();
                    sortBubble = Sort.bubbleSort(genArray);
                    stopWatch.stop();
                    bubbleTime = stopWatch.elapsedMicroseconds / 1000000;
                    stopWatch.reset();
                    stopWatch.start();
                    sortMerge = Sort.mergeSort(genArray);
                    stopWatch.stop();
                    mergeTime = stopWatch.elapsedMicroseconds / 1000000;
                    stopWatch.reset();
                    stopWatch.start();
                    sortShell = Sort.shellSort(genArray);
                    stopWatch.stop();
                    shellTime = stopWatch.elapsedMicroseconds / 1000000;
                    stopWatch.reset();
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 52),
              child: Visibility(
                visible: sortBubble.isNotEmpty,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 238, 211),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: titlePadding,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Bubble Sort Final Time: $bubbleTime seconds',
                            style: titleStyle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: textPadding,
                        child: Text(
                          sortBubble.toString(),
                          style: numberStyle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: titlePadding,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Merge Sort Final Time: $mergeTime seconds',
                            style: titleStyle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: textPadding,
                        child: Text(
                          sortMerge.toString(),
                          style: numberStyle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: titlePadding,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Shell Sort Final Time: $shellTime seconds',
                            style: titleStyle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
                        child: Text(
                          sortShell.toString(),
                          style: numberStyle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<int> _generateArray(int length) {
    List<int> array = List.generate(length, (index) => index);
    array.shuffle();

    return array;
  }
}

class Button extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const Button({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.deepOrange[900]),
          minimumSize: WidgetStateProperty.all(const Size(150, 50))),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
