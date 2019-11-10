package com.example.theja.main;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.ListView;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.example.theja.R;
import com.example.theja.busInfo.BusArrival;
import com.example.theja.busInfo.BusInfoActivity;
import com.example.theja.busInfo.BusRoute;

import java.util.List;
import java.util.Vector;

public class MainActivity extends AppCompatActivity {

    private ListView listView;
    private ListViewAdapter listViewAdapter;
    private Vector<ListViewItem> vehicleList; // 리스트뷰 리스트

    private BusArrival busArrival = new BusArrival(); // 버스 도착 정보 파싱 클래스
    private List<String> msg; // 메시지

    String key = "b6uH6X9Fql01CqlgeuVFN%2F8uAMSf061dkr86yJPO6BYMgFHAMoi9ZgK30BGNdSYywuZLyOnwjL9%2FtvT9iapVWQ%3D%3D"; // busInfo api key

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // 대중교통 리스트뷰
        listView = (ListView) findViewById(R.id.listView);
        listViewAdapter = new ListViewAdapter();
        listView.setAdapter(listViewAdapter);
        vehicleList = listViewAdapter.listViewItemList;

        // 대중교통 추가 버튼
        Button addBus = (Button) findViewById(R.id.addVehicle);
        addBus.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getApplicationContext(), BusInfoActivity.class);
                startActivityForResult(intent, 0);
            }
        });

        // 리스트뷰 삭제 이벤트
        listView.setOnItemLongClickListener(new AdapterView.OnItemLongClickListener() {
            @Override
            public boolean onItemLongClick(AdapterView<?> parent, View view, final int position, long id) {
                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        // TODO Auto-generated method stub

                        runOnUiThread(new Runnable() {

                            @Override
                            public void run() {
                                // TODO Auto-generated method stub

                                vehicleList.remove(position);
                                listViewAdapter.notifyDataSetChanged();

                            }
                        });

                    }
                }).start();

                return true;
            }
        });

    }

    // 대중교통 검색 결과 리턴
    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == RESULT_OK) {
            BusRoute bus = (BusRoute) data.getSerializableExtra("bus");
            addListViewItem(bus.getArsId(), bus.getStNm(), bus.getBusRouteNm());
        }
    }

    // 리스트뷰 추가 메소드
    public void addListViewItem(final int arsId, final String stNm, final String routeNm) {
        new Thread(new Runnable() {
            @Override
            public void run() {
                // TODO Auto-generated method stub

                msg = busArrival.getBusArrival(arsId, routeNm, key);

                runOnUiThread(new Runnable() {

                    @Override
                    public void run() {
                        // TODO Auto-generated method stub

                        listViewAdapter.addItem(routeNm, stNm, msg.get(0), msg.get(1));

                    }
                });

            }
        }).start();
    }

}
