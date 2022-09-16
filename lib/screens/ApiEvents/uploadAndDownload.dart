import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:dio/dio.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:progress_dialog/progress_dialog.dart';

String url = "https://api.cloudconvert.com/v2/jobs";

// String token = DotEnv().env['API_TOKEN'];
String sandToken =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNGQ5MmI2YjE0MjdhYzk4ODZlOTY4ZjE5NzRhYzg5OWVhODk1ZmFmOWJjOWNmODIyZDU2ODdmN2ViNDYyYWU1YWUwY2U2OGFjYWZkNzg2MzciLCJpYXQiOjE2NjMzMzAxOTkuOTU2OTkyLCJuYmYiOjE2NjMzMzAxOTkuOTU2OTk0LCJleHAiOjQ4MTkwMDM3OTkuOTUyMzM3LCJzdWIiOiI1OTgyMzUxMSIsInNjb3BlcyI6WyJ1c2VyLnJlYWQiLCJ1c2VyLndyaXRlIiwidGFzay5yZWFkIiwidGFzay53cml0ZSIsIndlYmhvb2sucmVhZCIsIndlYmhvb2sud3JpdGUiLCJwcmVzZXQucmVhZCIsInByZXNldC53cml0ZSJdfQ.C-2zdezKBcmwSQgq8pUz6OcPYidhPj1PG7wYgBrgBpdg8whbF-hJiByxSc9dap7OmCMz5h3CE-kN_p53gmP5e4vkvU_-bQsXtxNRV0FDy8wX39gte8TkzCAy3SqGSQM8YxIoY3wTHFJitNo03XjgSFgs9Qwvt6SW8hdzUP3b6e0wfcHHJI70zzqlnl6B0yt7y8-NVBJOXB_FWcgPu1vzGT_97mjLLQnl5M47YY5zXaPRaBcuAPxXvKkWtsQq_0auzzY6wXeqr612N15JCxEiG7-YuP-8Z-BC1vjdUj4T65WDyKkP3XFNipf_9E8iNIKJyzW6bH7RXLdqoBAJDAdCuH1o4_wKqJ2G4efVuEU0SoNnxFxRBa7Cw-sloLw1pb3r-Sps4JbIw_kf2plGK1kF2Ar0TqlxWEyRD_6glUiSHZ7mdC2V7mHldEIg7vheqnHjkIuxy5_Np6HE1t4FUYQNApojLXTqvvLG4-gaV21nJkh4zpPh-M3wM3Eo2JHwi3rhLoLFASZ5zjifDbBKEQ5aMXrtv4fFBCWwo6UuA8d8DENQ1LQJ3zmIrgAOaymCgv-q5IXX_1B76nP-zi8XOy-LkpOcWlxhuj7iRhGt9u59TItyQOIIcmaPNXAwlkhlLWYi2yW8px-7QcSY4m0OEAscgOABwI93VELSlOChDL-x-9I';
String token =
    "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMmVjOWZhNTJiYmNiYjNkNThjNDExMWJmZmNmMTJhNDFmNTE4NzVmYmU5NDQxMzI0OTViYjYxMDVmOTU3NmM1YjViOWM2Mjk2YTRjZTU0M2YiLCJpYXQiOjE2NjMzMjk5NzQuNzA0MTAyLCJuYmYiOjE2NjMzMjk5NzQuNzA0MTA0LCJleHAiOjQ4MTkwMDM1NzQuNjkzNjI0LCJzdWIiOiI1OTgyMzUxMSIsInNjb3BlcyI6WyJ1c2VyLnJlYWQiLCJ1c2VyLndyaXRlIiwidGFzay5yZWFkIiwidGFzay53cml0ZSIsIndlYmhvb2sucmVhZCIsIndlYmhvb2sud3JpdGUiLCJwcmVzZXQucmVhZCIsInByZXNldC53cml0ZSJdfQ.mtIc1a8uJe167mGB_cWjV0GT1mGuOVG16xewQYvPxT5xysgj9x-Z3NXLrZFYw6excw2hs-6Yo49Gt3cLfsiwA7c--xwgY2wo-0rb6HHgVoam5cfSAWT0FgH5DPUGu2N5hc2fHzYDgqT967_T7TjAlTMeW5DryWdvWS_x2yteQU4ofdZnEu6pzcPYRJOyZIZpz6Af6WP75QUAeX7JWpfR0r_cV-OiuPjz6K2HCiH0c6yQpAjousJcctI9LBdcpRWTCaReZy4MzfRKqLXySVMVVt0UDFgdzqBouH96_vmj5YofIAKIpZ6CspvjnPQFzTV9q-meTv4-SYnNUM7Y_3-HDawzN3gaq1kyv0UUtuJZDzX_VVMj48o-p8IajGO_DhS2LM-WcMpXqZC87sTDHss7zuYPB2RAuPCniUjuMCVZGCccRBGOcmFJ1zbPcwSAnvRbCFwrw2d7nCfJU0C-Nraq7on5_AAFYi8st9juHwgydeodB9GO2xUW56lUIDz9qu8sdF9mluzidmEc_P1NC650gn5SIWCdPVy0bXJqUR3JIKy7WvSnp3nnfxCAQSovvwTw3uSLbmPXuoijVx-wOEhrO5q3VSOmceXjjlCXH1xGCOY-HOegCvoQbjkRU7UHtlTI_e2qF6OZV5CBxAD-tplndNVqkkrC3cSoPH-7GCycnOw";
Map<String, String> headers = {
  'Authorization': 'Bearer $token',
  'Content-type': 'application/json'
};
var dio = Dio();
ProgressDialog pr;

Future<List<String>> createUploadJob(String inputType, String outputType,
    List<String> paths, BuildContext context) async {
  Map<String, dynamic> tempBodyImportTag = {};
  List<String> importList = [];

  for (var i = 1; i <= paths.length; i++) {
    tempBodyImportTag.addAll({
      // "file_import": {"operation": "import/upload"},
      "import-$i": {"operation": "import/upload"},
    });
    importList.add("import-$i");
  }
  print('-----------------top\n');
  log(importList.toString());
  print('-----------------\n');

  tempBodyImportTag.addAll({
    // "file_conversion": {
    //   "operation": "convert",
    //   "input_format": inputType,
    //   "output_format": outputType,
    //   "engine": "libreoffice",
    //   "input": importList,
    //   "pdf_a": false,
    //   "filename": "converted.pdf"
    // },
    // "file_export": {
    //   "operation": "export/url",
    //   "input": ["file_conversion"],
    //   "inline": false,
    //   "archive_multiple_files": false
    // }
    "task-1": {
      "operation": "convert",
      "input_format": inputType,
      "output_format": outputType,
      "input": importList,
    },
    "export-1": {
      "operation": "export/url",
      "input": ["task-1"],
    }
  });

  var body = jsonEncode({
    "tasks": tempBodyImportTag,
  });

  print(body);

  try {
    Response<Map> response = await dio.post(url,
        options: Options(
          headers: headers,
        ),
        data: body);

    Map<String, dynamic> res = response.data;
    print("****************\n");
    log(importList.toString());
    print("****************\n");
    log(response.data.toString());
    print("****************\n");
    return await uploadFilePost(res, paths);
  } catch (e) {
    print(e);
    if (e is DioError) {
      return Future.error(
          'Oops Something went wrong ! Plz check Internet connection.');
    } else {
      return Future.error(
          'Seems our API broke please reinstall this app or try later!');
    }
  }
}

Future<List<String>> uploadFilePost(
    Map<String, dynamic> res, List<String> paths) async {
  List<String> downloadLinks = [];
  List<Map<String, dynamic>> parameters = [];
  List<String> postUrl = [];

  for (var i = 0; i < paths.length; i++) {
    parameters.add(res["data"]["tasks"][i]["result"]["form"]["parameters"]);
    postUrl.add(res["data"]["tasks"][i]["result"]["form"]["url"]);

    FormData formData = new FormData.fromMap({
      "expires": parameters[i]["expires"],
      "max_file_count": 1,
      "max_file_size": 10000000000,
      "redirect": parameters[i]["redirect"],
      "signature": parameters[i]["signature"],
      "file": await MultipartFile.fromFile(paths[i],
          filename: p.basename(paths[i])),
    });

    try {
      Response postRessponse = await dio.post(postUrl[i],
          options: Options(headers: headers), data: formData);
      if (postRessponse.statusCode == 201) {
        continue;
      } else {
        break;
      }
    } catch (e) {
      return Future.error(
          'Oops Something went wrong ! Plz check Internet connection.');
    }
  }
  try {
    while (true) {
      Response<Map> downloadResponse = await dio.getUri(
          Uri.parse(res["data"]["links"]["self"]),
          options: Options(headers: headers));

      print(downloadResponse.data["data"]["status"]);

      if (downloadResponse.data["data"]["status"] == "waiting" ||
          downloadResponse.data["data"]["status"] == "processing") {
        continue;
      } else if (downloadResponse.data["data"]["status"] == "finished") {
        for (var i = 0; i < paths.length; i++) {
          downloadLinks.add(downloadResponse.data["data"]["tasks"][i]["result"]
              ["files"][0]["url"]);
        }
        break;
      }
    }
    return downloadLinks;
  } catch (e) {
    return e;
  }
}
