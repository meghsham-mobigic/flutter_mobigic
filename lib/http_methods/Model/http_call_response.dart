class HttpCallResponse {
  HttpCallResponse({this.responseData, this.errorData = ''});

  late dynamic responseData;
  late String errorData;

  dynamic get getResponseData => responseData;
  dynamic get getErrorData => errorData;
}
