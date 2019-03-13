import 'package:tas_mobile_api/tas_mobile_api.dart';

class Orders extends ManagedObject<TB_Order> implements TB_Order {
  String get detail => '$title';
}

class TB_Order {
  @primaryKey
  int id;

  @Column()
  String title;

  @Column()
  String location;

  @Column()
  DateTime dateContent;

  @Column()
  String payment;

  @Column()
  String pic;
}