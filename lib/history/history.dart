import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:transcribe/constant/constant.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'History',
            style: size20,
          ),
        ),
        body: ValueListenableBuilder(
            valueListenable: Hive.box('history').listenable(),
            builder: (context, value, child) {
              if (value.isEmpty) {
                return Center(
                  child: Text(
                    'No History',
                    style: size20,
                  ),
                );
              }
              return ListView.builder(
                itemCount: Hive.box('history').length,
                itemBuilder: (context, index) {
                  var box = value;
                  var get = box.getAt(index);
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      title: Text(
                        get.words,
                        style: size16,
                      ),
                      subtitle: Text(
                        get.translate,
                        style: size16,
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            box.deleteAt(index);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          )),
                    ),
                  );
                },
              );
            }));
  }
}
