package com.example.theja.forecastInfo;

import android.os.AsyncTask;
import android.util.Log;
import android.widget.Toast;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class WeatherInfo {

    private boolean umbrella = false;
    private String tempMax = "0";
    private String tempMin = "0";

    private String url;
    public List<String> weather;

    public WeatherInfo(String url){
        this.url = url;
        weather = new ArrayList<>();
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
                    JSONObject jObject = new JSONObject(readed);
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
                tempMin = result.getJSONObject("main").getString("temp_min")+"℃";
                tempMax = result.getJSONObject("main").getString("temp_max")+"℃";

                if(result.getJSONArray("weather").getJSONObject(0).getString("main").equals("Rain")){
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
