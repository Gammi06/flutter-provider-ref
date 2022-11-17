import 'package:http/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final httpConnector = Provider<HttpConnector>((ref) {
  return HttpConnector();
});

class HttpConnector {
  final host = "http://localhost:5000";
  final Client _client = Client();
  final headers = {"Content-Type": "application/json;charset=utf-8"};

  // 플러터는 단일스레드를 사용한다.
  // 따라서 유저가 입력을 하나하면 다른 행동을 할 수 없다.
  // 응답을 받기 전까지 CPU는 다른 행동을 할 수 없다.
  // 메모리가 다운을 받는 pending시간 동안 CPU는 멈춰야한다.
  // (멈추지않으면 null을 리턴하게 됨 -> 다운이 다 되지도 않았는데 리턴했기 때문에)
  Future<Response> get(String path) async {
    Uri uri = Uri.parse("${host}${path}");
    print("repository: 11111111111");
    Response response = await _client.get(uri);
    print("repository: 22222222222"); // 메모장에 적고 빠져나갈 때 await 이후로 실행X

    // CPU는 pending 시간동안 멈춰야 한다.(await - 멈춤 < BIO(BlockingIO))
    // 그래서 Promise라는 개념이 생김
    /*
    promise : 약속된 내용을 메모장에 적어두고 할 일이 없을 때가서 메모장을 확인함
      해야될 일이 있을 때 할 일을 함 ->  일이 끝나면 메모장을 확인함
      단점) 운이 안좋으면 지나칠 수 있음
      => 이벤트 기간이 긴 이벤트에서 사용하면 안됨 (짧은 것만 처리)
      => 이벤트 기간이 긴 이벤트는 서버 쪽에서 처리하기
      사용법)
      await에 async를 달면 CPU가 메모장에 할 일을 적어놓고 다른 일을 하러 간다.
      -> 메서드를 빠져 나옴 -> 지역변수들이 사라져서 null이 되는데, null을 넘길 수 없어서 Future를 리턴함 (나중에 줄것) -> 스택이 종료되더라도 메모리가 지역변수를 죽이지 않고 살려둠(호이스팅) == 리턴을 두번함(처음: 퓨처, 다음: 정상값)
      promise는 퓨처박스를 리턴하고 나중에 할 일이 없어서 돌아왔을때 주기로 했던 값을 리턴한다.
    * */
    return response;
  }

  Future<Response> post(String path, String body) async {
    Uri uri = Uri.parse("${host}${path}");
    Response response = await _client.post(uri, body: body, headers: headers);
    return response;
  }

  Future<Response> delete(String path) async {
    Uri uri = Uri.parse("${host}${path}");
    Response response = await _client.delete(uri);
    return response;
  }

  Future<Response> put(String path, String body) async {
    Uri uri = Uri.parse("${host}${path}");
    Response response = await _client.put(uri, body: body, headers: headers);
    return response;
  }
}
