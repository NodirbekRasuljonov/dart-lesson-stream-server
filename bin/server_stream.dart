import 'dart:io';
// import 'package:http/http.dart' as http;
void main(List<String> args) async {
  File mainpage=File("D:\\dart-practice\\server-homework\\server-stream\\bin\\html\\mainpage.html");
  File kirish=File("D:\\dart-practice\\server-homework\\server-stream\\bin\\html\\kirish.html");
  File contact=File("D:\\dart-practice\\server-homework\\server-stream\\bin\\html\\contactpage.html");
  File error=File("D:\\dart-practice\\server-homework\\server-stream\\bin\\html\\error.html");
  Stream<HttpRequest> server;
  try {
    server=await HttpServer.bind('127.0.0.1', 3000);
    print("Server ishga tushdi");
  } catch (e) {
    print("Server ishga tushmadi");
    exit(-1);
  }
  server.listen((HttpRequest request) async {
    Uri url=request.uri;
    request.response.headers.contentType=ContentType.html;
    switch(url.toString()){
      case '/':{
        print("Main Page mavjud");
        await request.response.addStream(mainpage.openRead());
        await request.response.close();
      }break;
      case '/kirish':{
        await request.response.addStream(kirish.openRead());
        print("Kirish safiha mavjud");
        await request.response.close();
      }break;
      case '/contact':{
        await request.response.addStream(contact.openRead());
        print("Contact Page mavjud");
        await request.response.close();
      }break;
      default:{
        await request.response.addStream(error.openRead());
        await request.response.close();
      }break;

    }
  });

}