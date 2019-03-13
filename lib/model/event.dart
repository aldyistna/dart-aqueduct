import 'package:tas_mobile_api/tas_mobile_api.dart';

class Events extends ManagedObject<Event> implements Event {
  String get detail => '';
}

class Event {
  @primaryKey
  int id;

  @Column()
  String event_name;

  @Column()
  DateTime event_date;

  @Column()
  String event_address_maps;

  @Column()
  String event_location;
}