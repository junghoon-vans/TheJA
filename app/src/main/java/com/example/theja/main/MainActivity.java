package com.example.theja.main;

import android.Manifest;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Color;
import android.location.LocationManager;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.AdapterView;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import com.example.theja.R;
import com.example.theja.UserData;
import com.example.theja.busInfo.BusArrival;
import com.example.theja.busInfo.BusInfoActivity;
import com.example.theja.busInfo.BusRoute;
import com.example.theja.forecastInfo.DustInfo;
import com.example.theja.forecastInfo.GeopositionFinder;
import com.example.theja.forecastInfo.LocationFinder;
import com.example.theja.forecastInfo.WeatherInfo;
import com.google.android.material.floatingactionbutton.FloatingActionButton;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {

    // FloatingActionButton
    private FloatingActionButton fab_main, fab_sub1, fab_sub2;
    private Animation fab_open, fab_close;
    private boolean isFabOpen = false;

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

    // GPS 위치정보 획득
    private LocationFinder locationFinder;
    private static final int GPS_ENABLE_REQUEST_CODE = 2001;
    private static final int PERMISSIONS_REQUEST_CODE = 100;
    private String locationID, locationName;

    String[] REQUIRED_PERMISSIONS  = {Manifest.permission.ACCESS_FINE_LOCATION, Manifest.permission.ACCESS_COARSE_LOCATION};

    Context context = MainActivity.this ;

    // API Keys
    String busApiKey = "b6uH6X9Fql01CqlgeuVFN%2F8uAMSf061dkr86yJPO6BYMgFHAMoi9ZgK30BGNdSYywuZLyOnwjL9%2FtvT9iapVWQ%3D%3D";
    String weatherApiKey = "1Pqm2QTnKfO0ik4yVJahaIO7ljt3OdCA";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // fab 설정
        fab_open = AnimationUtils.loadAnimation(context, R.anim.fab_open);
        fab_close = AnimationUtils.loadAnimation(context, R.anim.fab_close);

        fab_main = (FloatingActionButton) findViewById(R.id.fab_main);
        fab_sub1 = (FloatingActionButton) findViewById(R.id.fab_sub1);
        fab_sub2 = (FloatingActionButton) findViewById(R.id.fab_sub2);

        fab_main.setOnClickListener(this);
        fab_sub1.setOnClickListener(this);
        fab_sub2.setOnClickListener(this);

        //툴바 설정
        Toolbar toolBar = (Toolbar) findViewById(R.id.toolbar);
        toolBar.setTitleTextColor(Color.parseColor("#ffff33"));
        toolBar.setSubtitle("좀만 더자고 학교가자");
        toolBar.setNavigationIcon(R.mipmap.ic_launcher_foreground_theja); //제목앞에 아이콘 넣기
        setSupportActionBar(toolBar);

        // 위치정보 조회
        if (checkLocationServices()) {
            checkPermission();
        }

        locationFinder = new LocationFinder(context); // 위경도 찾기

        // 기상정보 조회
        final ImageView umbrella = (ImageView) findViewById(R.id.umbrella);
        final TextView tempMax = (TextView) findViewById(R.id.tempMax);
        final TextView tempMin = (TextView) findViewById(R.id.tempMin);

        new Thread(new Runnable() {
            @Override
            public void run() {
                // TODO Auto-generated method stub
                final GeopositionFinder geopositionFinder = new GeopositionFinder(locationFinder.getLatitude(), locationFinder.getLongitude(), weatherApiKey); // 도시 정보 찾기
                locationID = geopositionFinder.getLocationID();
                locationName = geopositionFinder.getLocationName();

                final WeatherInfo weatherInfo = new WeatherInfo(locationID, weatherApiKey);

                runOnUiThread(new Runnable() {

                    @Override
                    public void run() {
                        // TODO Auto-generated method stub
                        tempMin.setText(weatherInfo.getTempMin());
                        tempMax.setText(weatherInfo.getTempMax());

                        if(weatherInfo.getUmbrella()){
                            umbrella.setImageResource(R.drawable.umbrella);
                        } else {
                            umbrella.setImageResource(R.drawable.umbrellax);
                        }
                    }
                });

            }
        }).start();

        // 대기정보 조회
        final ImageView mask = (ImageView) findViewById(R.id.mask);
        new Thread(new Runnable() {
            @Override
            public void run() {
                // TODO Auto-generated method stub

                DustInfo dustInfo = new DustInfo();
                final boolean isDust = dustInfo.getDustInfo();
                runOnUiThread(new Runnable() {

                    @Override
                    public void run() {
                        // TODO Auto-generated method stub
                        if (isDust) {
                            mask.setImageResource(R.drawable.mask);
                        } else {
                            mask.setImageResource(R.drawable.maskx);
                        }
                    }
                });

            }
        }).start();

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

                    msg = busArrival.getBusArrival(arsId, routeNm, busApiKey);
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
                        msg = busArrival.getBusArrival(arsId, routeNm, busApiKey);

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

                msg = busArrival.getBusArrival(arsId, routeNm, busApiKey);


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

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.fab_main:
                toggleFab();
                break;

            case R.id.fab_sub1:
                toggleFab();
                Intent intent = new Intent(getApplicationContext(), BusInfoActivity.class);
                startActivityForResult(intent, 0);
                break;

            case R.id.fab_sub2:
                toggleFab();
                Toast.makeText(this, "지하철 추가 기능은 아직 준비중입니다 :)", Toast.LENGTH_SHORT).show();
                break;
        }

    }

    @Override
    public void onRequestPermissionsResult(int permsRequestCode,
                                           @NonNull String[] permissions,
                                           @NonNull int[] grandResults) {

        if (permsRequestCode == PERMISSIONS_REQUEST_CODE && grandResults.length == REQUIRED_PERMISSIONS.length) {
            boolean check_result = true;

            for (int result : grandResults) {
                if (result != PackageManager.PERMISSION_GRANTED) {
                    check_result = false;
                    break;
                }
            }
            if ( check_result ) {
                ;
            }
            else {
                // 퍼미션이 거부된 경우
                if (ActivityCompat.shouldShowRequestPermissionRationale(this, REQUIRED_PERMISSIONS[0])
                        || ActivityCompat.shouldShowRequestPermissionRationale(this, REQUIRED_PERMISSIONS[1])) {
                    Toast.makeText(context, "퍼미션이 거부되었습니다. 앱을 다시 실행하여 퍼미션을 허용해주세요.", Toast.LENGTH_LONG).show();
                    finish();
                }else {
                    Toast.makeText(context, "퍼미션이 거부되었습니다. 설정(앱 정보)에서 퍼미션을 허용해야 합니다. ", Toast.LENGTH_LONG).show();
                }
            }

        }
    }

    void checkPermission(){
        int hasFineLocationPermission = ContextCompat.checkSelfPermission(context,
                Manifest.permission.ACCESS_FINE_LOCATION);
        int hasCoarseLocationPermission = ContextCompat.checkSelfPermission(context,
                Manifest.permission.ACCESS_COARSE_LOCATION);

        if (hasFineLocationPermission != PackageManager.PERMISSION_GRANTED ||
                hasCoarseLocationPermission != PackageManager.PERMISSION_GRANTED) {
            if (ActivityCompat.shouldShowRequestPermissionRationale(this, REQUIRED_PERMISSIONS[0])) {
                Toast.makeText(context, "이 앱을 실행하려면 위치 접근 권한이 필요합니다.", Toast.LENGTH_LONG).show();
                ActivityCompat.requestPermissions(this, REQUIRED_PERMISSIONS, PERMISSIONS_REQUEST_CODE);
            } else {
                ActivityCompat.requestPermissions(this, REQUIRED_PERMISSIONS, PERMISSIONS_REQUEST_CODE);
            }
        }
    }

    public boolean checkLocationServices() {
        LocationManager locationManager = (LocationManager) getSystemService(LOCATION_SERVICE);
        return locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)
                || locationManager.isProviderEnabled(LocationManager.NETWORK_PROVIDER);
    }

    private void toggleFab() {
        if (isFabOpen) {
            fab_main.setImageResource(R.drawable.ic_add);
            fab_sub1.startAnimation(fab_close);
            fab_sub2.startAnimation(fab_close);
            fab_sub1.setClickable(false);
            fab_sub2.setClickable(false);
            isFabOpen = false;
        } else {
            fab_main.setImageResource(R.drawable.ic_close);
            fab_sub1.startAnimation(fab_open);
            fab_sub2.startAnimation(fab_open);
            fab_sub1.setClickable(true);
            fab_sub2.setClickable(true);
            isFabOpen = true;
        }
    }

}
