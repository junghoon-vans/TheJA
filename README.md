TheJA
===

Project in Myongji University major course (Mobile Computing).

![version](https://img.shields.io/badge/Version-1.6.0-green.svg)
![language](https://img.shields.io/badge/Language-Java-Orange.svg)
![android](https://img.shields.io/badge/android-10(api_level_29)-Blue.svg)

:open_book: Introduction
---
아침에 바쁜 대학생들에게 필요한 정보만을 빠르게 제공하는 애플리케이션입니다. 챙겨야 하는 물건(우산이나 미세먼지 마스크)을 아이콘으로 쉽게 파악할 수 있도록 하였으며 최저온도, 최고온도도 표기하여 날씨에 맞는 옷을 입을 수 있도록 하였습니다. 또한 자주 사용하는 대중교통을 메인 화면에 등록하여 언제 버스나 지하철이 정류장(혹은 역)에 도착하는 지 확인할 수 있는 기능도 제공합니다.

:scroll: History
---

- 2019년 1학기: 명지대학교 전공수업(모바일 컴퓨팅) 개인 프로젝트로 개발 시작
- 2019년 11월:  *명지대학교 융합소프트웨어학부 제 2회 공모전* 에서 **우수상 수상**

![수상사진](수상사진.jpg)

:writing_hand: Release Note
---

- [v1.0](https://github.com/Jeonghun-Ban/TheJA/releases/tag/v1.0)
    - 학교 전공으로 진행한 개인 프로젝트
    - 안드로이드 9.0(Pie) 기반으로 개발
    - 날씨 정보, 미세먼지 정보 제공
    - 버스 도착 정보 리스트뷰
- [v1.6](https://github.com/Jeonghun-Ban/TheJA/releases/tag/v1.6)
    - 안드로이드 10 기반으로 재구축
    - 위치 정보 기반 날씨 획득 기능 추가

:file_folder: Source Code
---
[Root Directory](/app/src/main/java/com/example/theja)
- [main](app\src\main\java\com\example\theja\main)
    - [MainActivity](app\src\main\java\com\example\theja\main\MainActivity.java): 메인 액티비티
    - [ListViewItem](app\src\main\java\com\example\theja\main\ListViewItem.java): 리스트뷰 데이터 정의
    - [ListViewAdapter](app\src\main\java\com\example\theja\main\ListViewAdapter.java): 리스트뷰 어댑터
    - [Vehicle](app\src\main\java\com\example\theja\main\Vehicle.java): 대중교통 데이터 정의
- [forecastInfo](app\src\main\java\com\example\theja\forecastInfo)
    - [DustInfo](app\src\main\java\com\example\theja\forecastInfo\DustInfo.java): 미세먼지 정보 파싱 클래스
    - [WeatherInfo](app\src\main\java\com\example\theja\forecastInfo\WeatherInfo.java): 날씨 정보 파싱 클래스
- [busInfo](app\src\main\java\com\example\theja\busInfo)
    - [BusInfoActivity](app\src\main\java\com\example\theja\busInfo\BusInfoActivity.java): 버스 정보 검색 액티비티
    - [BusArrival](app\src\main\java\com\example\theja\busInfo\BusArrival.java): 버스 도착 정보 파싱 클래스
    - [BusInfo](app\src\main\java\com\example\theja\busInfo\BusInfo.java): 버스 정보 파싱 클래스
    - [BusRoute](app\src\main\java\com\example\theja\busInfo\BusRoute.java): 버스 루트 클래스
    - [BusStop](app\src\main\java\com\example\theja\busInfo\BusStop.java): 버스 정거장 클래스
- [UserData](app\src\main\java\com\example\theja\UserData.java): Store UserData in Shared Preference
