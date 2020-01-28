TheJA
===
![version](https://img.shields.io/badge/Version-1.6.0-green.svg)
![language](https://img.shields.io/badge/Language-Java-Orange.svg)
![android](https://img.shields.io/badge/android-application-Blue.svg)

Project in Myongji University major course (Mobile Computing).

명지대학교 전공수업(모바일 컴퓨팅)에서 진행한 개인 프로젝트해당 프로젝트로 명지대학교 융합소프트웨어학부 제 2회 공모전에서 우수상 수상하였습니다.

![수상사진](수상사진.jpg)

Release Note
---

- [v1.0](https://github.com/Jeonghun-Ban/TheJA/releases/tag/v1.0)

Source Code
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