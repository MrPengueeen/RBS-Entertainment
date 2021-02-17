import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http_parser/http_parser.dart';

const BaseUrl = 'http://167.86.115.146:8099/api/v1/';
const noInternetMsg = 'You are not connected to Internet';
const errorMsg = 'Please try again later.';

/// Shared Pref
const ACCESS = 'ACCESS';
const USER_ID = 'USER_ID';
const LOGGED_IN = 'LOGGED_IN';
const FULL_NAME = 'FIRST_NAME';
const USERNAME = 'USERNAME';

/// Variables
var accessAllowed = false;

bool isSuccessful(int code) {
  return code >= 200 && code <= 206;
}

Future<Response> getRequest(String endPoint,
    {bool bearerToken = false, bool noBaseUrl = false}) async {
  if (await isNetworkAvailable()) {
    var headers;
    Response response;
    var accessToken = await getString(ACCESS);
    print(accessToken);

    if (bearerToken) {
      headers = {
        HttpHeaders.acceptHeader: 'application/json; charset=utf-8',
        "Authorization": "Token $accessToken"
      };
    }

    print('URL: $BaseUrl$endPoint');
    print('Header: $headers');

    if (bearerToken) {
      response = await get('$BaseUrl$endPoint', headers: headers);
    } else if (noBaseUrl) {
      response = await get('$endPoint');
    } else {
      response = await get('$BaseUrl$endPoint');
    }

    print('Response: ${response.statusCode} ${response.body}');
    return response;
  } else {
    throw noInternetMsg;
  }
}

postRequest(
  String endPoint,
  Map request, {
  bool requireToken = false,
  bool bearerToken = false,
  bool isDigitToken = false,
}) async {
  if (await isNetworkAvailable()) {
    print('URL: $BaseUrl$endPoint');
    print('Request: $request');

    var accessToken = await getString(ACCESS);

    var headers;

    if (bearerToken) {
      headers = {
        HttpHeaders.acceptHeader: 'application/json; charset=utf-8',
        "Authorization": "Token $accessToken"
      };
    }

    print("Headers: $headers");
    Response response =
        await post('$BaseUrl' + '$endPoint', body: request, headers: headers);
    print('Response: ${response.statusCode} ${response.body}');
    return response;
  } else {
    throw noInternetMsg;
  }
}

putRequest(
  String endPoint,
  Map request, {
  bool requireToken = false,
  bool bearerToken = false,
  bool isDigitToken = false,
}) async {
  if (await isNetworkAvailable()) {
    print('URL: $BaseUrl$endPoint');
    print('Request: $request');

    var accessToken = await getString(ACCESS);

    var headers = {
      HttpHeaders.acceptHeader: 'application/json; charset=utf-8',
    };

    if (bearerToken) {
      var header = {"Authorization": "Token $accessToken"};
      headers.addAll(header);
    }

    print("Headers: $headers");
    Response response =
        await put('$BaseUrl' + '$endPoint', body: request, headers: headers);
    print('Response: ${response.statusCode} ${response.body}');
    return response;
  } else {
    throw noInternetMsg;
  }
}

// Future multiPartRequest(String endPoint, Map body,
//     {File file, String filename}) async {
//   if (await isNetworkAvailable()) {
//     ///MultiPart request
//     var request = MultipartRequest(
//       'PUT',
//       Uri.parse("https://.../api/v1/users/profile/update"),
//     );

//     var accessToken = await getString(ACCESS);

//     Map<String, String> headers = {
//       HttpHeaders.acceptHeader: 'application/json; charset=utf-8',
//       "Authorization": "Token $accessToken",
//       "Content-type": "multipart/form-data",
//     };

//     if (file != null && filename != null) {
//       request.files.add(
//         MultipartFile(
//           'profile_image',
//           file.readAsBytes().asStream(),
//           file.lengthSync(),
//           filename: filename,
//           contentType: MediaType('image', 'jpeg'),
//         ),
//       );
//     }

//     request.headers.addAll(headers);
//     request.fields.addAll(body);

//     print('Request: $request');
//     StreamedResponse streamedResponse = await request.send();
//     Response response = await Response.fromStream(streamedResponse);
//     print('Response: ${response.statusCode} ${response.body}');
//     return response;
//   } else {
//     throw noInternetMsg;
//   }
// }

Future handleResponse(Response response) async {
  if (!await isNetworkAvailable()) {
    throw noInternetMsg;
  }
  if (isSuccessful(response.statusCode)) {
    if (response.body.isNotEmpty) {
      //print('isNotEmpty : ${response.body}');
      return jsonDecode(response.body);
    } else
      return response.body;
  } else {
    if (response.body.isJson()) {
      print("handleResponse: ${jsonDecode(response.body)}");
      toast("${jsonDecode(response.body)['non_field_errors'][0]}" +
          ". Try Again");
      return Future.error('${response.statusCode} Error');
    } else {
      print("handleResponse: ${jsonDecode(response.body)}");
      return Future.error('${response.statusCode} Error');
    }
  }
}

Future<bool> isJsonValid(json) async {
  try {
    var f = jsonDecode(json) as Map<String, dynamic>;
    return true;
  } catch (e) {
    print(e.toString());
  }
  return false;
}

patchRequest(
  String endPoint,
  Map request, {
  bool requireToken = false,
  bool bearerToken = false,
  bool isDigitToken = false,
}) {}

deleteRequest(String endPoint,
    {bool requireToken = false, bool bearerToken = false}) async {
  if (await isNetworkAvailable()) {
    print('URL: $BaseUrl$endPoint');

    var headers = {
      HttpHeaders.acceptHeader: 'application/json; charset=utf-8',
    };

    if (requireToken) {
      var header = {
        "token": "${await getString(ACCESS)}",
        "id": "${await getInt(USER_ID)}"
      };
      headers.addAll(header);
    }
    if (bearerToken) {
      var header = {"Authorization": "Token ${await getString(ACCESS)}"};
      headers.addAll(header);
    }

    print(headers);
    Response response =
        await delete('$BaseUrl' + '$endPoint', headers: headers);
    print('Response: ${response.statusCode} ${response.body}');
    return response;
  } else {
    throw noInternetMsg;
  }
}
