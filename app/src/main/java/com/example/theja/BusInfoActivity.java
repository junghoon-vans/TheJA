package com.example.theja;

import android.util.Log;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;

import androidx.appcompat.app.AppCompatActivity;

import java.util.List;
import java.util.Vector;

public class BusInfoActivity extends AppCompatActivity {

    // layout
    EditText search;
    Button search_button;

    // List
    List<String> stationList = new Vector<>();
    List<String> vehicleList = new Vector<>();
    List<BusStop> busStopList; // BusStopList

    // Search BusInfo
    BusInfo busInfo = new BusInfo();
    // BusInfo api key
    String key = "uXFV5e0IO1Fgdcb6PbNGLRdSdalYvJGYaYrbA3nKpLJguCaPC%2F1P5LgOUvkBJa3sao%2BrRTjXRX0HXoI6wPtf9g%3D%3D";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_bus_info);

        // search
        search = (EditText)findViewById(R.id.search);
        search_button = (Button)findViewById(R.id.search_button);

        // ListView
        final ArrayAdapter<String> stationAdapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, stationList);
        final ListView stationListView = (ListView)findViewById(R.id.station);
        stationListView.setAdapter(stationAdapter);

        final ArrayAdapter<String> vehicleAdapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, vehicleList);
        final ListView vehicleListView = (ListView)findViewById(R.id.route);
        vehicleListView.setAdapter(vehicleAdapter);

        // click search btn
        search_button.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                stationListView.setVisibility(View.VISIBLE);
                vehicleListView.setVisibility(View.GONE);

                new Thread(new Runnable() {

                    @Override
                    public void run() {
                        // TODO Auto-generated method stub
                        stationList.clear();
                        busStopList = busInfo.getBusStop(search, key);

                        for(int i=0; i<busStopList.size();i++){
                            int arsId = busStopList.get(i).arsId;
                            String stNm = busStopList.get(i).stNm;

                            stationList.add(stNm+" | "+Integer.toString(arsId));
                        }

                        runOnUiThread(new Runnable() {

                            @Override
                            public void run() {
                                // TODO Auto-generated method stub
                                stationAdapter.notifyDataSetChanged();
                            }
                        });

                    }
                }).start();

            }
        });
    }
}
