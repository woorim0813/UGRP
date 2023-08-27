1.1.1a (8월 13일)
 - 세션 세부 페이지 (via contentpage.dart)
  1. 기초 작업 완료
 - 홈화면 (via home.dart)
  1. 세션 검색 기능 개선
  2. 세션 새로고침 기능 추가
 - 세션 생성 (via new.dart / sessions.js / storedb)
  1. 가게 선택을 위한 storedb 생성 및 연결
  2. currentorder 변수 반영

1.1.1b (8월 13일)
 - 세션 생성 (via sessions.js)
  1. create_time 변수 반영
  2. finaltime 변수 활용 세션 삭제 기능 구현

1.1.2a (8월 17일)
 - 세션 삭제 (via sessions.js)
  1. create_time 변수 활용 세션 삭제 기능 구현
  2. 디버깅 성능 이슈로 주석 처리 필요
 - 세션 생성 (via new.dart)
  1. add_new4 초안 완성
 - 신규 데이터 (via home.dart / new.dart / storedb / menudb)
  1. 긴 텍스트 대응 예외 처리

1.1.2b
 - 세션 세부 페이지 (via ContentPage.dart / sessions.js / home.dart)
  1. 세션 정보 확인 및 메뉴 주문 기능 추가
  2. 세션 참가 기능 추가
  (한 사용자 최대 한 개 세션 이용)
 - 신규 DB (via sessions.js)
  1. userid, sessionid, userorder 저장
  2. 사용자 세션 참가 여부, 주문 확인 가능

1.2a
 - 서버 통신 기능 보완 (via home.dart / new.dart)
  1. 새로 고침 없이 데이터 비동기 처리
 - 세션 지도 별 표시 기능 준비 (via maps.dart)
  1. Google Maps API 사용
  2. 화면 첫 로드 시 사용자 위치로 자동 이동
  3. Markers 및 BottomSheet 사용
