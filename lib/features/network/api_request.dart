import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pixal_lab_bloc/features/model/pixal_api_model.dart';
import 'package:pixal_lab_bloc/util/constant.dart';

class ApiRequest {
  Future<PixalLabApiModel?> getAllImages(String url) async {
   
    return await http.get(Uri.parse(url),
        headers: {"Authorization": apikey}).then((value) {
      print("response is >> ${jsonDecode(value.body)}");
      if (value.statusCode == 200) {
        PixalLabApiModel pixalLabApiModel =
            PixalLabApiModel.fromJson(jsonDecode(value.body));
        
        return pixalLabApiModel;
      } else {}
      return null;
    });
  }
}
