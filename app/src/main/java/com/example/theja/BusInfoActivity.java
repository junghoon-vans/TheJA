package com.example.theja;

import android.os.Bundle;
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
    }
}
