import 'package:mime/mime.dart';
import 'package:tas_mobile_api/tas_mobile_api.dart';


class UploadController extends ResourceController {
  UploadController() {
    acceptedContentTypes = [ContentType("multipart", "form-data")];
  }

  @Operation.post()
  Future<Response> postForm() async {
    final transformer = MimeMultipartTransformer(request.raw.headers.contentType.parameters["boundary"]);
    final bodyStream = Stream.fromIterable([await request.body.decode<List<int>>()]);
    final parts = await transformer.bind(bodyStream).toList();

    for (var part in parts) {
      final headers = part.headers;
      final content = await part.toList();
      // ...
    }    

    return Response.ok(parts);

  }
}