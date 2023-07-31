
import 'package:crud_firebase/domain/models/person.dart';

abstract class PersonRepository {
  Future<List<Person>> getPersons();
  Future<bool> addPerson(Person person);
  Future<bool> deletePerson(String id);
  Future<bool> updatePerson(Person person);
}