package com.example.theja.busInfo;

import android.util.Log;
import android.widget.EditText;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

// 버스 정보 검색
public class BusInfo {

    List<BusStop> getBusStop(EditText search, String key) {
        List<BusStop> busStopList = new ArrayList<>();

        String str = search.getText().toString();
        @SuppressWarnings("deprecation")
        String location = URLEncoder.encode(str); // str to url

        String queryUrl = "http://ws.bus.go.kr/api/rest/stationinfo/getStationByName?serviceKey=" +
                key + "&stSrch=" + location;

        try {
            URL url = new URL(queryUrl); //검색 url
            InputStream input = url.openStream();

            XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
            XmlPullParser xpp = factory.newPullParser();
            xpp.setInput(new InputStreamReader(input, "UTF-8")); //inputstream 으로부터 xml 입력받기

            String tag, text;
            boolean arsId = false;
            boolean stNm = false;

            xpp.next();
            int eventType = xpp.getEventType();

            // create bus instance
            BusStop busStop = new BusStop(); // 버스 정류소 정보
            while (eventType != XmlPullParser.END_DOCUMENT) {

                switch (eventType) {
                    case XmlPullParser.START_DOCUMENT:
                        break;
                    case XmlPullParser.START_TAG:
                        tag = xpp.getName();

                        if (tag.equals("itemList")) {
                            busStop = new BusStop();
                        } else if (tag.equals("arsId")) {
                            arsId = true;
                        } else if (tag.equals("stNm")) {
                            stNm = true;
                        }
                        break;
                    case XmlPullParser.TEXT:
                        if (arsId) {
                            text = xpp.getText();
                            busStop.arsId = Integer.parseInt(text);
                            arsId = false;
                        } else if (stNm) {
                            text = xpp.getText();
                            busStop.stNm = text;
                            stNm = false;
                            busStopList.add(busStop);
                        }
                        break;
                    case XmlPullParser.END_TAG:
                        break;
                }
                eventType = xpp.next();

            }

        } catch (Exception e) {
            Log.e("에러", e.toString());
        }

        return busStopList;
    }

    List<BusRoute> getBusRoute(int selectedItem, String key){
        List<BusRoute> busRouteList = new ArrayList<>();

        String queryUrl = "http://ws.bus.go.kr/api/rest/stationinfo/getRouteByStation?serviceKey=" +
                key + "&arsId=" + selectedItem;
        try{
            URL url = new URL(queryUrl); //검색 url
            InputStream input = url.openStream();

            XmlPullParserFactory factory= XmlPullParserFactory.newInstance();
            XmlPullParser xpp= factory.newPullParser();
            xpp.setInput( new InputStreamReader(input, "UTF-8") ); //inputstream 으로부터 xml 입력받기

            String tag, text;
            boolean busRouteNm = false;
            boolean stEnd = false;

            xpp.next();
            int eventType = xpp.getEventType();

            // create busRoute instance
            BusRoute busRoute = new BusRoute(); // 특정 정류소의 버스 정보
            while( eventType != XmlPullParser.END_DOCUMENT ){

                switch ( eventType ){
                    case XmlPullParser.START_DOCUMENT:
                        break;
                    case XmlPullParser.START_TAG:
                        tag = xpp.getName();

                        if(tag.equals("itemList")){
                            busRoute = new BusRoute();
                        } else if(tag.equals("busRouteNm")){
                            busRouteNm = true;
                        } else if(tag.equals("stEnd")){
                            stEnd = true;
                        }
                        break;
                    case XmlPullParser.TEXT:
                        if (busRouteNm){
                            text = xpp.getText();
                            busRoute.busRouteNm = text;
                            busRouteNm = false;
                        } else if (stEnd){
                            text = xpp.getText();
                            busRoute.stEnd = text;
                            stEnd = false;
                            busRouteList.add(busRoute);
                        }
                        break;
                    case XmlPullParser.END_TAG:
                        break;
                }
                eventType=xpp.next();

            }

        } catch (Exception e) {
            Log.e("에러", e.toString());
        }

        return busRouteList;

    }
}