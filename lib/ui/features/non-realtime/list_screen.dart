
import 'package:crud_firebase/domain/models/person.dart';
import 'package:crud_firebase/domain/repository/person_repository.dart';
import 'package:crud_firebase/ui/features/non-realtime/add_screen.dart';
import 'package:crud_firebase/ui/features/non-realtime/list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListNoRealtimeScreen extends StatefulWidget {
  const ListNoRealtimeScreen._();

  static Widget init() => ChangeNotifierProvider(
    lazy: false,
    create: (context) => ListNoRealtimeProvider(personRepository: context.read<PersonRepository>(),
    )..load(),
    child: const ListNoRealtimeScreen._(),
  );

  @override
  State<ListNoRealtimeScreen> createState() => _ListNoRealtimeScreenState();
}

class _ListNoRealtimeScreenState extends State<ListNoRealtimeScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListNoRealtimeProvider>();
    final persons = provider.persons;
    return Scaffold(
      appBar: AppBar(),
      body: persons == null ? 
        const Center(child: CircularProgressIndicator(),)
        : ListView.builder(
          itemCount: persons.length,
          itemBuilder: (context, index) {
            final el = persons[index];
            return ListTile(
              onTap: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AddScreen.init(person: el)
                  )
                );
                if(result != null && mounted) {
                  context.read<ListNoRealtimeProvider>().update(result);
                }
                /* if(mounted) context.read<ListNoRealtimeProvider>().load(); */
              },
              onLongPress: (){
                context.read<ListNoRealtimeProvider>().delete(el.id!);
              },
              title: Text('${el.name} ${el.lastname}'),
              subtitle: Text(el.gender),
            );
          },
        ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.of(context).push<Person?>(
            MaterialPageRoute(
              builder: (_) => AddScreen.init()
            )
          );
          if(result != null && mounted) {
            context.read<ListNoRealtimeProvider>().add(result);
          }
        },
      ),
    );
  }
}
