class ResponseDTO {
  ResponseDTO({this.responseData = '', this.error = ''});

  dynamic responseData;
  String error;

  //
  // dynamic get getResponseData => responseData;
  // dynamic get getErrorData => errorData;
}
