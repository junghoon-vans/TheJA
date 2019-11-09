package com.example.theja.busInfo;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;

import androidx.appcompat.app.AppCompatActivity;

import com.example.theja.R;

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
    List<BusRoute> busRouteList; // BusRouteList

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

        // BusStop ListView Click event
        stationListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {

            @Override
            public void onItemClick(AdapterView<?> parent, View view, final int position, long id) {
                stationListView.setVisibility(View.GONE);
                vehicleListView.setVisibility(View.VISIBLE);

                new Thread(new Runnable() {

                    @Override
                    public void run() {
                        // TODO Auto-generated method stub
                        final int arsId = busStopList.get(position).arsId; // 선택한 정류소
                        final String stNm = busStopList.get(position).stNm;
                        busRouteList = busInfo.getBusRoute(arsId, key);

                        for(int i = 0; i< busRouteList.size(); i++){
                            busRouteList.get(i).setArsId(arsId);
                            busRouteList.get(i).setStNm(stNm);
                            String busRouteNm = busRouteList.get(i).busRouteNm;
                            String stEnd = busRouteList.get(i).stEnd;

                            vehicleList.add(busRouteNm+" | "+stEnd+"방면");
                        }

                        runOnUiThread(new Runnable() {

                            @Override
                            public void run() {
                                // TODO Auto-generated method stub
                                vehicleAdapter.notifyDataSetChanged();
                            }
                        });

                    }
                }).start();

            }

        });

        vehicleListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {

            @Override
            public void onItemClick(AdapterView<?> parent, View view, final int position, long id) {
                Intent intent = getIntent();
                intent.putExtra("bus", busRouteList.get(position)); // 선택한 버스 객체 반환
                setResult(RESULT_OK, intent);
                finish();
            }

        });

    }
}
