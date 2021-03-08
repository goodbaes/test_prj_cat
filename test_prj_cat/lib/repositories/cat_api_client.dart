import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class UrlImg {
  String url;

  UrlImg({this.url});

  UrlImg.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}

class CatApiClient {
  final String url =
      'https://api.thecatapi.com/v1/images/search?api_key=e9deaf58-d444-4a0e-b688-81dda3c34c9b';
  Future getImg(imgUrl) async {
    http.Response responsei = await http.get(Uri.parse(imgUrl));
    final bytes = responsei.bodyBytes;
    final bytesEncode = base64Encode(bytes);
    final Uint8List uniList = base64Decode(bytesEncode);
    return (uniList != null ? uniList : null);
  }

  Future getImgUrl() async {
    final http.Response response = await http.get(Uri.parse(url));
    if (response != null) {
      var data = jsonDecode(response.body);
      var imgBase = getImg(data[0]['url']);
      return imgBase;
    } else {
      print(response.statusCode);
    }
  }
}
