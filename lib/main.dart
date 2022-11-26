import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'schedule.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  ScheduleData scheduleData = ScheduleData();
  late List<String> groups = scheduleData.getGroupsNames();
  String? selectedGroup;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Group'),
        centerTitle: true,
      ),
      body: Center(
        child: Row(

          children: [
            Container(
              margin: EdgeInsets.fromLTRB(300, 0, 75, 0),
              child:
              ElevatedButton(
                onPressed: () {
                  selectedGroup = groups[0];
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Home(selectedGroup: selectedGroup)));
                },
                child: Text('KB-41'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                ),


              ),),
            Container(
              margin: EdgeInsets.fromLTRB(75, 0, 75, 0),child:
            ElevatedButton(
              onPressed: () {
                selectedGroup = groups[1];
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Home(selectedGroup: selectedGroup)));
              },
              child: Text('KB-42'),
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                padding: EdgeInsets.fromLTRB(50, 20, 50, 20),),
            ),),
            Container(margin: EdgeInsets.fromLTRB(75, 0, 75, 0),child:
            ElevatedButton(
              onPressed: () {
                selectedGroup = groups[2];
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Home(selectedGroup: selectedGroup)));
              },
              child: Text('KB-43'),
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                padding: EdgeInsets.fromLTRB(50, 20, 50, 20),),
            ),),
            Container(margin: EdgeInsets.fromLTRB(75, 0, 75, 0),child:
            ElevatedButton(
              onPressed: () {
                selectedGroup = groups[3];
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Home(selectedGroup: selectedGroup)));
              },
              child: Text('KB-44'),
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
              ),
            ))

          ],
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  String? selectedGroup;
  Home({required this.selectedGroup});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    ScheduleData scheduleData = ScheduleData();
    Schedule schedule = scheduleData.getScheduleForGroup(selectedGroup);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Schedule'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(children: [
          Expanded(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  String dayName = scheduleData.getDayName(index);
                  List<List<String>> subjects = [];
                  schedule.dayToSubjects[dayName]?.subjects.forEach(
                          (key, value) => subjects.add([key.toString(), value]));

                  return ExpansionTile(
                      title: Text(dayName),
                      backgroundColor: Colors.yellow,
                      collapsedBackgroundColor: Colors.black,
                      textColor: Colors.black,
                      collapsedTextColor: Colors.white,
                      children: subjects
                          .map((value) =>
                          ListTile(title: Text(value[0] + '. ' + value[1])))
                          .toList());
                },
                separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
              ))
        ]),
      ),
    );
  }
}