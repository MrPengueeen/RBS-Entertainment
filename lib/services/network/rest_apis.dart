import 'dart:io';

import 'package:RBS/services/network/api_handlers.dart';

///  AUTH
Future registerUser(Map request) async {
  return handleResponse(
      await postRequest('auth/signup/', request, requireToken: false));
}

Future signInUser(Map request) async {
  return handleResponse(
      await postRequest('auth/api-token-auth/', request, requireToken: false));
}

Future resetPassword(Map request) async {
  return handleResponse(
      await postRequest('auth/reset-password/', request, requireToken: false));
}

Future confirmPassword(Map request) async {
  return handleResponse(
      await postRequest('auth/reset-password/', request, requireToken: false));
}
