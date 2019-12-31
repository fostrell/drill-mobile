class HttpResponse<T> {
  final String error;
  final T data;

  HttpResponse({
    this.data,
    this.error,
  });
}
