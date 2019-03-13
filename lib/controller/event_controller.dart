import 'package:tas_mobile_api/tas_mobile_api.dart';

import 'package:tas_mobile_api/model/event.dart';

class EventController extends ResourceController {
  EventController(this.context);

  ManagedContext context;

  @Operation.get()
  Future<Response> getAllInbox() async {
    final readQuery = Query<Events>(context)
    ..sortBy((event) => event.id, QuerySortOrder.ascending);
    return Response.ok(await readQuery.fetch());
  }
}