import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/domain/models/person.dart';
import 'package:crud_firebase/domain/repository/person_repository.dart';

class PersonFirebase implements PersonRepository {
  final personRef =
      FirebaseFirestore.instance.collection('persons').withConverter<Person>(
            fromFirestore: (snapshot, _) {
              final person = Person.fromJson(snapshot.data()!);
              final newPerson = person.copyWith(id: snapshot.id);
              return newPerson;
            },
            toFirestore: (person, _) => person.toJson(),
          );

  @override
  Future<List<Person>> getPersons() async {
    final querySnapshot = await personRef.get();
    final persons = querySnapshot.docs.map((e) => e.data()).toList();
    return persons;
  }

  @override
  Future<Person> addPerson(Person person) async {
    final result = await personRef.add(person);
    return person.copyWith(id: result.id);
  }

  @override
  Future<bool> deletePerson(String id) async {
    await personRef.doc(id).delete();
    return true;
  }

  @override
  Future<Person> updatePerson(Person person) async {
    await personRef.doc(person.id).update(person.toJson());
    return person;
  }

  @override
  Stream<List<Person>> getPersonsStream() {
    final result = personRef.snapshots().map(
      (event) => event.docs.map(
        (e) => e.data(),
      ).toList(),
    );
    return result;
  }
}
