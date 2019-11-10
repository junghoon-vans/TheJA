package com.example.theja.main;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.ListView;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.example.theja.R;
import com.example.theja.UserData;
import com.example.theja.busInfo.BusArrival;
import com.example.theja.busInfo.BusInfoActivity;
import com.example.theja.busInfo.BusRoute;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

public class MainActivity extends AppCompatActivity {

    // 리스트뷰 관련 클래스
    private ListView listView;
    private ListViewAdapter listViewAdapter;
    private Vector<ListViewItem> listViewItems;

    // 버스 도착 정보 파싱 클래스
    private BusArrival busArrival = new BusArrival();
    // 도착 정보 메시지
    private List<String> msg;

    // 대중교통 정보 저장 SharedPreperence
    private UserData userData = new UserData();
    // 저장된 대중교통 정보 리스트
    private List<Vehicle> vehicleList = new ArrayList<>();
    private ArrayList<String> searchIdList = new ArrayList<>();
    private ArrayList<String> stationList = new ArrayList<>();
    private ArrayList<String> routeList = new ArrayList<>();

    Context context = MainActivity.this;
    String key = "b6uH6X9Fql01CqlgeuVFN%2F8uAMSf061dkr86yJPO6BYMgFHAMoi9ZgK30BGNdSYywuZLyOnwjL9%2FtvT9iapVWQ%3D%3D"; // busInfo api key

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // 대중교통 리스트뷰
        listView = (ListView) findViewById(R.id.listView);
        listViewAdapter = new ListViewAdapter();
        listView.setAdapter(listViewAdapter);
        listViewItems = listViewAdapter.listViewItemList;

        // 저장된 정보 불러오기
        searchIdList = userData.getStringArrayPref(context, "arsId");
        stationList = userData.getStringArrayPref(context, "stNm");
        routeList = userData.getStringArrayPref(context, "routeNm");

        for(int i=0; i<searchIdList.size(); i++){ // vehicleList 복구
            int arsId = Integer.parseInt(searchIdList.get(i));
            String stNm = stationList.get(i);
            String routeNm = routeList.get(i);

            Vehicle vehicle = new Vehicle(arsId, stNm, routeNm);
            vehicleList.add(vehicle);
        }

        new Thread(new Runnable() { // index size == 0 에러 수정
            @Override
            public void run() {
                // TODO Auto-generated method stub

                for(int i=0; i<vehicleList.size(); i++){
                    int arsId = vehicleList.get(i).getSearchId();
                    String routeNm = vehicleList.get(i).getRoute();
                    String stNm = vehicleList.get(i).getStation();

                    msg = busArrival.getBusArrival(arsId, routeNm, key);
                    if(msg.size()!=0){
                        listViewAdapter.addItem(routeNm, stNm, msg.get(0), msg.get(1));
                    }else{
                        listViewAdapter.addItem(routeNm, stNm, "통신에러", "통신에러");
                    }
                }

                runOnUiThread(new Runnable() {

                    @Override
                    public void run() {
                        // TODO Auto-generated method stub

                        listViewAdapter.notifyDataSetChanged();

                    }
                });

            }
        }).start();

        // 대중교통 추가 버튼
        Button addBus = (Button) findViewById(R.id.addVehicle);
        addBus.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getApplicationContext(), BusInfoActivity.class);
                startActivityForResult(intent, 0);
            }
        });

        // 리스트뷰 동기화 이벤트
        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, final int position, long id) {
                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        // TODO Auto-generated method stub

                        int arsId = vehicleList.get(position).getSearchId();
                        String routeNm = vehicleList.get(position).getRoute();
                        msg = busArrival.getBusArrival(arsId, routeNm, key);

                        runOnUiThread(new Runnable() {

                            @Override
                            public void run() {
                                // TODO Auto-generated method stub
                                if(msg.size()!=0) {
                                    listViewAdapter.update(position, msg.get(0), msg.get(1));
                                    listViewAdapter.notifyDataSetChanged();
                                }else{
                                    Toast.makeText(getApplicationContext(), "네트워크상에 문제가 있습니다, 잠시후 다시 시도하세요", Toast.LENGTH_LONG).show();
                                }
                            }
                        });

                    }
                }).start();
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

                        vehicleList.remove(position);
                        searchIdList.clear();
                        stationList.clear();
                        routeList.clear();

                        // 리스트 나눠서 저장 (arsId, stNm, routeNm)
                        for(int i=0; i<vehicleList.size(); i++){
                            searchIdList.add(Integer.toString(vehicleList.get(i).getSearchId()));
                            stationList.add(vehicleList.get(i).getStation());
                            routeList.add(vehicleList.get(i).getRoute());
                        }

                        // 마지막 리스트를 삭제할 경우
                        if(vehicleList.size()==0){
                            userData.removeStringArrayPref(context, "arsId");
                            userData.removeStringArrayPref(context, "stNm");
                            userData.removeStringArrayPref(context, "routeNm");

                        }else{
                            userData.setStringArrayPref(context,"arsId", searchIdList);
                            userData.setStringArrayPref(context,"stNm", stationList);
                            userData.setStringArrayPref(context,"routeNm", routeList);
                        }


                        runOnUiThread(new Runnable() {

                            @Override
                            public void run() {
                                // TODO Auto-generated method stub

                                listViewItems.remove(position);
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

                // vehicleList 추가
                Vehicle vehicle = new Vehicle(arsId, stNm,routeNm);
                vehicleList.add(vehicle);

                searchIdList.clear();
                stationList.clear();
                routeList.clear();

                // 리스트 나눠서 저장 (arsId, stNm, routeNm)
                for(int i=0; i<vehicleList.size(); i++){
                    searchIdList.add(Integer.toString(vehicleList.get(i).getSearchId()));
                    stationList.add(vehicleList.get(i).getStation());
                    routeList.add(vehicleList.get(i).getRoute());
                }
                userData.setStringArrayPref(context,"arsId", searchIdList);
                userData.setStringArrayPref(context,"stNm", stationList);
                userData.setStringArrayPref(context,"routeNm", routeList);

                msg = busArrival.getBusArrival(arsId, routeNm, key);


                runOnUiThread(new Runnable() {

                    @Override
                    public void run() {
                        // TODO Auto-generated method stub
                        if(msg.size()!=0){
                            listViewAdapter.addItem(routeNm, stNm, msg.get(0), msg.get(1));
                            listViewAdapter.notifyDataSetChanged();
                        }else{
                            Toast.makeText(getApplicationContext(), "네트워크상에 문제가 있습니다, 잠시후 다시 시도하세요", Toast.LENGTH_LONG).show();
                        }

                    }
                });

            }
        }).start();
    }

}
