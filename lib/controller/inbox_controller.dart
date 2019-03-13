import 'package:tas_mobile_api/tas_mobile_api.dart';

import 'package:tas_mobile_api/model/inbox.dart';


class InboxController extends ResourceController {
  InboxController(this.context);

  ManagedContext context;

  @Operation.get()
  Future<Response> getAllInbox() async {
    final readQuery = Query<Inboxes>(context)
      ..sortBy((u) => u.dateMsg, QuerySortOrder.descending);
    return Response.ok(await readQuery.fetch());
  }

  @Operation.get('id')
  Future<Response> getOneInbox(@Bind.path('id') int id) async {
    final readQuery = Query<Inboxes>(context)
      ..where((inbox) => inbox.id).equalTo(id);
    final read = await readQuery.fetchOne();

    if (read == null) {
      return Response.notFound(body: 'Inbox not found');
    }
    
    return Response.ok(read); 
  }

  @Operation.post()
  Future<Response> createInbox(@Bind.body() Inboxes body) async {
    final readQuery = Query<Inboxes>(context)..values = body;
    final insertedQuery = await readQuery.insert();

    return Response.ok(insertedQuery);
  }

  @Operation.put('id')
  Future<Response> updateInbox(@Bind.path('id') int id, @Bind.body() Inboxes body) async {
    final readQuery = Query<Inboxes>(context)
      ..values = body
      ..where((inbox) => inbox.id).equalTo(id);
    
    final updatedQuery = await readQuery.updateOne();

    if (updatedQuery == null) {
      return Response.notFound(body: 'Inbox not found.');
    }

    return Response.ok(updatedQuery);
  }

  @Operation.delete('id')
  Future<Response> deleteInbox(@Bind.path('id') int id) async {
    final readQuery = Query<Inboxes>(context)
      ..where((inbox) => inbox.id).equalTo(id);

    final deleteCount = await readQuery.delete();
    
    if (deleteCount == 0) {
      return Response.notFound(body: 'Inbox not found.');
    }
    
    return Response.ok('Deleted $deleteCount items.');
  }
}