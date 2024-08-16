import 'dart:async';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:transcribe/constant/constant.dart';
import 'package:transcribe/history/history.dart';
import 'package:transcribe/model/model.dart';
import 'package:transcribe/settings/settings.dart';
import 'package:translator/translator.dart';

class TranscribePage extends StatefulWidget {
  const TranscribePage({super.key});

  @override
  State<TranscribePage> createState() => _TranscribePageState();
}

class _TranscribePageState extends State<TranscribePage> {
  late final Box dataBox;
  bool isConnected = false;
  bool isListening = false;
  late stt.SpeechToText _speechToText;
  String words = 'Speak...';
  // List<Map<String, String>> entries = [];
  late StreamSubscription connSub;
  String selectedValueto = 'Yoruba';
  String to = 'yo';
  String selectedValuefrom = 'English';
  String from = 'en';
  List<String> languages = [
    'Yoruba',
    'Igbo',
    'Hausa',
    'French',
  ];
  List<String> languagesCode = [
    'yo',
    'ig',
    'ha',
    'fr',
  ];
  List<String> languagesfr = [
    'English',
    'French',
    'Spanish',
    'Russian',
  ];
  List<String> languagesCodefr = [
    'en',
    'fr',
    'es',
    'ru',
  ];
  // String translate = '--';

  @override
  void initState() {
    _speechToText = stt.SpeechToText();
    connSub = InternetConnection().onStatusChange.listen((event) {
      print(event);
      switch (event) {
        case InternetStatus.connected:
          setState(() {
            isConnected = true;
          });
          break;
        case InternetStatus.disconnected:
          setState(() {
            isConnected = false;
          });
          break;
        default:
          setState(() {
            isConnected = false;
          });
          break;
      }
    });
    dataBox = Hive.box('history');
    super.initState();
  }

  Future get() async {
    if (!isListening) {
      bool listen = await _speechToText.initialize();
      if (listen) {
        setState(() {
          isListening = true;
        });
        _speechToText.listen(
            localeId: from,
            onResult: (result) => setState(() {
                  words = result.recognizedWords;
                  if (result.finalResult) {
                    convert();
                  }
                }));
      }
    } else {
      setState(() {
        isListening = false;
      });
      _speechToText.stop();
    }
  }

  final translator = GoogleTranslator();
  bool _loading = false;
  // Timer? debounce;
  convert() async {
    setState(() {
      _loading = true;
    });
    try {
      await translator.translate(words, from: from, to: to).then((value) {
        setState(() {
          final data = TranscribeModel(words: words, translate: value.text);
          dataBox.add(data);
        });

        print(value);
      });
    } catch (e) {
      print('Translation error: $e');
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    connSub!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Transcribe',
          style: size20,
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isConnected
              ? Expanded(
                  child: ValueListenableBuilder(
                      valueListenable: dataBox.listenable(),
                      builder: (context, value, _) {
                        return ListView.builder(
                            itemCount: dataBox.length,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            itemBuilder: (context, index) {
                              var box = value;
                              var entries = box.getAt(index);
                              return Container(
                                // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                margin: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      textAlign: TextAlign.start,
                                      entries.words,
                                      style: size16,
                                    ),
                                    Divider(),
                                    Text(
                                      textAlign: TextAlign.start,
                                      entries.translate,
                                      style: size16,
                                    )
                                  ],
                                ),
                              );
                            });
                      }))
              : Expanded(
                  child: Column(
                  children: [
                    const Icon(
                      Icons.wifi_off_outlined,
                      color: Colors.red,
                    ),
                    Text(
                      'Please connect to an internet connection!',
                      style: size16,
                    )
                  ],
                )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12)),
                  width: 130,
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  alignment: Alignment.center,
                  child: DropdownButton(
                    isExpanded: true,
                    dropdownColor: Colors.grey[800],
                    value: selectedValuefrom,
                    items: languagesfr.map((lang) {
                      return DropdownMenuItem(
                        value: lang,
                        child: Text(
                          lang,
                          style: size16w,
                        ),
                        onTap: () {
                          if (lang == languagesfr[0]) {
                            from = languagesCodefr[0];
                          } else if (lang == languagesfr[1]) {
                            from = languagesCodefr[1];
                          } else if (lang == languagesCodefr[2]) {
                            from = languagesCodefr[2];
                          } else if (lang == languagesfr[3]) {
                            from = languagesCodefr[3];
                          }
                          setState(() {
                            //translate();
                          });
                        },
                      );
                    }).toList(),
                    onChanged: ((value) {
                      selectedValuefrom = value!;
                    }),
                  ),
                ),
                Icon(
                  Icons.translate,
                  size: 25,
                  color: Colors.black,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12)),
                  width: 130,
                  height: 50,
                  child: DropdownButton(
                    isExpanded: true,
                    dropdownColor: Colors.grey[800],
                    value: selectedValueto,
                    items: languages.map((lang) {
                      return DropdownMenuItem(
                        value: lang,
                        child: Text(
                          lang,
                          style: size16w,
                        ),
                        onTap: () {
                          if (lang == languages[0]) {
                            to = languagesCode[0];
                          } else if (lang == languages[1]) {
                            to = languagesCode[1];
                          } else if (lang == languages[2]) {
                            to = languagesCode[2];
                          } else if (lang == languages[3]) {
                            to = languagesCode[3];
                          }
                          setState(() {
                            //translate();
                          });
                        },
                      );
                    }).toList(),
                    onChanged: ((value) {
                      selectedValueto = value!;
                    }),
                  ),
                ),
              ],
            ),
          ),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.black,
              ),
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingPage()));
                    },
                    icon: Icon(
                      Icons.settings,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: get,
                    icon: Icon(
                      isListening ? Icons.mic : Icons.mic_off_outlined,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HistoryPage()));
                    },
                    icon: Icon(
                      Icons.history,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
