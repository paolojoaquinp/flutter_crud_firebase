
import 'package:crud_firebase/domain/models/person.dart';
import 'package:crud_firebase/domain/repository/person_repository.dart';
import 'package:crud_firebase/ui/features/non-realtime/add_provider.dart';
import 'package:crud_firebase/ui/features/non-realtime/list_provider.dart';
import 'package:crud_firebase/ui/features/non-realtime/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen._(this.person);

  final Person person;

  static Widget init({required Person person}) => ChangeNotifierProvider(
    lazy: false,
    create: (context) => AddProvider(
      personRepository: context.read<PersonRepository>(),
    ),
    child: UpdateScreen._(person),
  );

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _controllerName = TextEditingController();
  final _controllerLastname = TextEditingController();
  final _controllerGender = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: _controllerName,
              decoration: const InputDecoration(
                label: Text('Name')
              ),
            ),
            TextField(
              controller: _controllerLastname,
              decoration: const InputDecoration(
                label: Text('Last Name')
              ),
            ),
            TextField(
              controller: _controllerGender,
              decoration: const InputDecoration(
                label: Text('Gender')
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () async {
          await context.read<AddProvider>().add(
            Person(
              name: _controllerName.text,
              lastname: _controllerLastname.text,
              gender: _controllerGender.text
            )
          );
          if (mounted) Navigator.of(context).pop();
        },
      ),
    );
  }
}
