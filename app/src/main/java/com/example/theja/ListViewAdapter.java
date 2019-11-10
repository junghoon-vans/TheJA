package com.example.theja;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import java.util.Vector;

public class ListViewAdapter extends BaseAdapter {
    public Vector<ListViewItem> listViewItemList = new Vector<>();

    @Override
    public int getCount() {
        return listViewItemList.size();
    }

    @Override
    public Object getItem(int position) {
        return listViewItemList.get(position) ;
    }

    @Override
    public long getItemId(int position) {
        return position ;
    }

    @Override
    public View getView(final int position, View convertView, ViewGroup parent) {
        final int pos = position;
        final Context context = parent.getContext();

        // "listview_item" Layout을 inflate하여 convertView 참조 획득.
        if (convertView == null) {
            LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            convertView = inflater.inflate(R.layout.listview, parent, false);
        }

        // 화면에 표시될 View(Layout이 inflate된)으로부터 위젯에 대한 참조 획득
        TextView vehicle = (TextView) convertView.findViewById(R.id.route);
        TextView station = (TextView) convertView.findViewById(R.id.station);
        TextView arrMsg1 = (TextView) convertView.findViewById(R.id.arrMsg1);
        TextView arrMsg2 = (TextView) convertView.findViewById(R.id.arrMsg2);

        // Data Set(filteredItemList)에서 position에 위치한 데이터 참조 획득
        ListViewItem listViewItem = listViewItemList.get(position);

        vehicle.setText(listViewItem.getVehicle());
        station.setText(listViewItem.getStation());
        arrMsg1.setText(listViewItem.getArrmsg1());
        arrMsg2.setText(listViewItem.getArrmsg2());

        return convertView;
    }

    public void addItem(String vehicle, String station, String arrMsg1, String arrMsg2) {
        ListViewItem item = new ListViewItem();
        item.setVehicle(vehicle);
        item.setStation(station);
        item.setArrmsg1(arrMsg1);
        item.setArrmsg2(arrMsg2);

        listViewItemList.add(item);
    }

    public void update(int index, String arrMsg1, String arrMsg2){
        listViewItemList.get(index).setArrmsg1(arrMsg1);
        listViewItemList.get(index).setArrmsg2(arrMsg2);
    }
    public void clearItem(){
        listViewItemList.clear();
    }
}