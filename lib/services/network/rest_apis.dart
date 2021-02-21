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

/// Contents

Future getMenuApi() async {
  return handleResponse(await getRequest('content/menu/', bearerToken: false));
}

Future getMoviesByMenu(int menuId, int page, int numberPerPage) async {
  return handleResponse(await getRequest(
      'content/movie/?page=$page&page_size=$numberPerPage&menu=$menuId',
      bearerToken: false));
}

Future getLatestMoviesByMenu(int menuId) async {
  return handleResponse(await getRequest(
      'content/movie/?page=1&page_size=10&menu=$menuId&ordering=-released',
      bearerToken: false));
}

Future getLatestMoviesForAll() async {
  return handleResponse(await getRequest(
      'content/movie/?page=1&page_size=10&ordering=-released',
      bearerToken: false));
}

Future getPopularMoviesForAll() async {
  return handleResponse(await getRequest(
      'content/movie/?page=1&page_size=10&ordering=-rating',
      bearerToken: false));
}

/// Subscription

Future getSubscriptionPackages() async {
  return handleResponse(
      await getRequest('subscription/subscription_plans/', bearerToken: false));
}

/// Transaction

Future getTransactionData(int planId, String price) async {
  return handleResponse(await getRequest('transection/checkout/$planId/$price',
      bearerToken: true));
}

Future getTransactionStatus(Map request) async {
  return handleResponse(await postRequest(
      'transection/return_url_response', request,
      bearerToken: true));
}

Future getMoviesBySearch(String searchTerm) async {
  return handleResponse(await getRequest('content/movie/?search=$searchTerm',
      bearerToken: false));
}
