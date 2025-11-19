import 'package:flutter/material.dart';
import '../models/task.dart';
import 'detail.dart';

class Ecran1 extends StatelessWidget {
  final List<Task> myTasks = Task.generateTask(6);

  Ecran1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LISTE STATISTIQUE'),  // <-- Le titre que tu souhaites
      ),
      body: ListView.builder(
        itemCount: myTasks.length,
        itemBuilder: (BuildContext context, int index) {
          final task = myTasks[index];
          return Card(
            color: Colors.white,
            elevation: 7,
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.lightBlue,
                child: Text(task.id.toString()),
              ),
              title: Text(task.title),
              subtitle: Text(task.tags.join(" ")),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Detail(task: task),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
