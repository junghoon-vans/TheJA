package com.example.theja.busInfo;

import android.util.Log;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class BusArrival { // 버스 도착 정보

    public String msg1, msg2;

    public List<String> getBusArrival(int arsId, String routeNm, String key){
        List<String> busArrival = new ArrayList<>();

        String queryUrl = "http://ws.bus.go.kr/api/rest/stationinfo/getStationByUid" +
                "?serviceKey=" + key + "&arsId=" + arsId;
        try{
            URL url = new URL(queryUrl); //검색 url
            InputStream input = url.openStream();

            XmlPullParserFactory factory= XmlPullParserFactory.newInstance();
            XmlPullParser xpp= factory.newPullParser();
            xpp.setInput( new InputStreamReader(input, "UTF-8") ); //inputstream 으로부터 xml 입력받기

            String tag, text;
            boolean rtNm = false;
            boolean arrmsg1 = false;
            boolean arrmsg2 = false;

            xpp.next();
            int eventType = xpp.getEventType();

            while( eventType != XmlPullParser.END_DOCUMENT ){

                switch ( eventType ){
                    case XmlPullParser.START_DOCUMENT:
                        break;
                    case XmlPullParser.START_TAG:
                        tag = xpp.getName();

                        if(tag.equals("itemList")){
                        } else if(tag.equals("arrmsg1")){
                            arrmsg1 = true;
                        } else if(tag.equals("arrmsg2")){
                            arrmsg2 = true;
                        } else if(tag.equals("rtNm")){
                            rtNm = true;
                        }
                        break;

                    case XmlPullParser.TEXT:
                        text = xpp.getText();
                        if (arrmsg1){
                            msg1 = text;
                            arrmsg1 = false;
                        } else if (arrmsg2){
                            msg2 = text;
                            arrmsg2 = false;
                        } else if (rtNm){
                            if(text.equals(routeNm)){
                                busArrival.add(msg1);
                                busArrival.add(msg2);
                                break;
                            }
                            rtNm = false;
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

        return busArrival;
    }

}