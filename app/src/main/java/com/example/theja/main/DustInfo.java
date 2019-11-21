package com.example.theja.main;

import android.util.Log;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;

public class DustInfo {

    boolean isDust = false; // 미세먼지 있음
    boolean pm10Grade = false;
    boolean pm25Grade = false;

    public boolean getDustInfo() {
        String queryUrl = "http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty" + // 미세먼지 api
                "?serviceKey=uXFV5e0IO1Fgdcb6PbNGLRdSdalYvJGYaYrbA3nKpLJguCaPC%2F1P5LgOUvkBJa3sao%2BrRTjXRX0HXoI6wPtf9g%3D%3D" + // 서비스키
                "&numOfRows=1&pageNo=1&stationName=%EC%84%9C%EB%8C%80%EB%AC%B8%EA%B5%AC&dataTerm=DAILY&ver=1.3";

        try{
            URL url = new URL(queryUrl); //검색 url
            InputStream input = url.openStream();

            XmlPullParserFactory factory= XmlPullParserFactory.newInstance();
            XmlPullParser xpp= factory.newPullParser();
            xpp.setInput( new InputStreamReader(input, "UTF-8") ); //inputstream 으로부터 xml 입력받기

            String tag, text;

            xpp.next();
            int eventType = xpp.getEventType();

            while( eventType != XmlPullParser.END_DOCUMENT ){
                switch ( eventType ){
                    case XmlPullParser.START_DOCUMENT:
                        break;
                    case XmlPullParser.START_TAG:
                        tag = xpp.getName();

                        if(tag.equals("item")){

                        } else if (tag.equals("pm10Grade")){
                            pm10Grade = true;
                        } else if(tag.equals("pm25Grade")){
                            pm25Grade = true;
                        }
                        break;
                    case XmlPullParser.TEXT:
                        text = xpp.getText();
                        if (pm10Grade||pm25Grade){
                            int grade = Integer.parseInt(text);
                            if(grade>2){
                                isDust = true;
                            }
                            pm10Grade = false;
                            pm25Grade = false;
                        }
                        break;
                    case XmlPullParser.END_TAG:
                        break;
                }
                eventType=xpp.next();

            }

        }catch (Exception e) {
            Log.e("에러", e.toString());
        }

        return isDust;
    }
}
