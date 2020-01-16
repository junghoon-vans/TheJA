package com.example.theja.main;

import android.util.Log;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class WeatherInfo {
    boolean condition = false;
    String umbrella = "false";
    boolean tmx = false; // temp max
    String tempMax = "-100";
    boolean tmn = false;  // temp min
    String tempMin = "100";
    boolean day = false;
    boolean found = false;
    boolean loop = true;

    public List<String> getWeatherInfo() {

        String queryUrl = "http://api.openweathermap.org/data/2.5/weather?lat=37.5805607&lon=126.923924&units=metric&appid=a0a3c6718f3ffee22f64c850d5662a7f&mode=xml"; // 기상청 조회
        List<String> weather = new ArrayList<>();

        try {
            URL url = new URL(queryUrl); //검색 url
            InputStream input = url.openStream();

            XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
            XmlPullParser xpp;
            xpp = factory.newPullParser();
            xpp.setInput(new InputStreamReader(input, "UTF-8")); //inputstream 으로부터 xml 입력받기

            String tag, text;

            xpp.next();
            int eventType = xpp.getEventType();

            while (eventType != XmlPullParser.END_DOCUMENT&&loop) {

                switch (eventType) {
                    case XmlPullParser.START_DOCUMENT:
                        break;
                    case XmlPullParser.START_TAG:
                        tag = xpp.getName();

                        if (tag.equals("temperature")) {
                            condition = true;
                        } else if (tag.equals("max")) {
                            tmx = true;
                        }
                        break;
                    case XmlPullParser.TEXT:
                        text = xpp.getText();
                        if (condition) {
                            if (text.contains("rain")) { // 기상예보에 비가 있을 경우 umbrella = "true"
                                umbrella = "true";
                            }
                            condition = false;
                        } else if (tmx) {

                        } else if (tmn) {

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

        weather.add(umbrella);
        weather.add(tempMax.replace(".0", "℃")); // 소수점 삭제
        weather.add(tempMin.replace(".0", "℃"));
        return weather;
    }

}
