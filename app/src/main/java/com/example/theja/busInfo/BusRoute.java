package com.example.theja.busInfo;

import java.io.Serializable;

@SuppressWarnings("serial")
public class BusRoute implements Serializable { // 버스 노선
    int arsId; // 정류소
    String stNm; // 버스 정류소 이름
    String busRouteNm; //버스 노선명
    String stEnd; // 종점

    public int getArsId() {
        return arsId;
    }

    public String getStNm() { return stNm; }

    public String getBusRouteNm() {
        return busRouteNm;
    }

    public String getStEnd() {
        return stEnd;
    }


    public void setArsId(int arsId) {
        this.arsId = arsId;
    }

    public void setStNm(String stNm) { this.stNm = stNm; }

    public void setBusRouteNm(String busRouteNm) {
        this.busRouteNm = busRouteNm;
    }

    public void setStEnd(String stEnd) {
        this.stEnd = stEnd;
    }
}