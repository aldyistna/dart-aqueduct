import 'package:tas_mobile_api/tas_mobile_api.dart';

import 'package:tas_mobile_api/model/order.dart';


class OrderController extends ResourceController {
  OrderController(this.context);

  ManagedContext context;

  @Operation.get()
  Future<Response> getAllInbox() async {
    final readQuery = Query<Orders>(context)
    ..sortBy((u) => u.id, QuerySortOrder.ascending);
    return Response.ok(await readQuery.fetch());
  }

  @Operation.post()
  Future<Response> createInbox(@Bind.body() Orders body) async {
    final readQuery = Query<Orders>(context)..values = body;
    final insertedQuery = await readQuery.insert();

    return Response.ok(insertedQuery);
  }

  @Operation.put('id')
  Future<Response> updateInbox(@Bind.path('id') int id, @Bind.body() Orders body) async {
    final readQuery = Query<Orders>(context)
      ..values = body
      ..where((book) => book.id).equalTo(id);
    
    final updatedQuery = await readQuery.updateOne();

    if (updatedQuery == null) {
      return Response.notFound(body: 'Order not found.');
    }

    return Response.ok(updatedQuery);
  }

  @Operation.delete()
  Future<Response> deleteInbox() async {
    return Response.ok("delete inbox");
  }
}