package com.example.theja.forecastInfo;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class GeopositionFinder {

    String url = "https://dataservice.accuweather.com" + "/locations/v1/cities/geoposition/search?";
    String locationID, locationName;

    public GeopositionFinder(double lat, double lon, String apiKey){
        url = url + "apikey=" + apiKey + "&q=" + lat + "," + lon + "&language=ko-kr";
        JSONObject jObject = getJSON();
        getLocation(jObject);
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

    private void getLocation(JSONObject result){

        if( result != null ){

            try {
                locationID = result.getString("Key");
                locationName = result.getJSONObject("AdministrativeArea").getString("LocalizedName").substring(0,2);
            }
            catch (JSONException e ) {
                e.printStackTrace();
            }
        }

    }

    public String getLocationID(){
        return locationID;
    }

    public String getLocationName(){
        return locationName;
    }

}
