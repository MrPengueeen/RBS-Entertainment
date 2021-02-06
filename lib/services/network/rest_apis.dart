import 'dart:io';

import 'package:RBS/services/network/api_handlers.dart';

/// User
Future registerUser(Map request) async {
  return handleResponse(
      await postRequest('auth/signup/', request, requireToken: false));
}

Future signInUser(Map request) async {
  return handleResponse(
      await postRequest('auth/api-token-auth/', request, requireToken: false));
}
