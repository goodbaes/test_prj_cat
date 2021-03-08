import 'dart:convert';
import 'package:http/http.dart' as http;

class CatApiClient {
  final String url =
      'https://api.thecatapi.com/v1/images/search?api_key=e9deaf58-d444-4a0e-b688-81dda3c34c9b';
  Future getImg(imgUrl) async {
    http.Response responsei = await http.get(Uri.parse(imgUrl));
    final bytes = responsei.bodyBytes;
    final bytesEncode = base64Encode(bytes);

    return (bytesEncode != null ? bytesEncode : null);
  }

  Future getImgUrl() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response != null) {
      String data = response.body;
      var img = jsonDecode(data);
      String imgUrl = img['url'];
      var bytesEncode = await getImg(imgUrl);
      return (bytesEncode != null ? bytesEncode : null);
    } else {
      print(response.statusCode);
    }
  }
}
