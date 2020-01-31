package com.example.theja.forecastInfo;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class WeatherInfo {

    private boolean umbrella = false;
    private String tempMax = "0";
    private String tempMin = "0";

    private String url = "http://dataservice.accuweather.com" + "/forecasts/v1/daily/1day/";

    public WeatherInfo(String locationID, String apiKey){
        url = url + locationID + "?apikey=" + apiKey + "&metric=true";
        JSONObject jObject = getJSON();
        getWeather(jObject);
    }

    private JSONObject getJSON(){
        try {
            HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();
            conn.setConnectTimeout(10000);
            conn.setReadTimeout(10000);
            conn.connect();

            if (conn.getResponseCode() == HttpURLConnection.HTTP_OK) {
                InputStream is = conn.getInputStream();
                InputStreamReader reader = new InputStreamReader(is);
                BufferedReader in = new BufferedReader(reader);

                String readed;
                while ((readed = in.readLine()) != null) {
                    JSONObject jObject = new JSONObject(readed).getJSONArray("DailyForecasts").getJSONObject(0);
                    return jObject;
                }
            } else {
                return null;
            }
            return null;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private void getWeather(JSONObject result){
        if( result != null ){

            try {
                JSONObject temp = result.getJSONObject("Temperature");
                tempMin = temp.getJSONObject("Minimum").getString("Value")+"℃";

                if(result.getJSONObject("Day").getString("IconPhrase").contains("Rain")){
                    umbrella = true;
                }

            }
            catch (JSONException e ) {
                e.printStackTrace();
            }
        }

    }

    public String getTempMin(){
        return tempMin;
    }

    public String getTempMax(){
        return tempMax;
    }

    public boolean getUmbrella(){
        return umbrella;
    }

}
