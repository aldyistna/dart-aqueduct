import 'package:tas_mobile_api/tas_mobile_api.dart';

class Inboxes extends ManagedObject<Inbox> implements Inbox {
  String get detail => '$content by $sender';
}

class Inbox {
  @primaryKey
  int id;

  @Column()
  String content;

  @Column()
  String sender;

  @Column()
  String profilePic;

  @Column()
  DateTime dateMsg;

  @Column()
  bool readStatus;
}