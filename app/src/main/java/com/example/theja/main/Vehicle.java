package com.example.theja.main;

public class Vehicle {
    int searchId;
    String station; // stNm
    String route; // routeNm

    public Vehicle(int searchId, String station, String route){
        this.searchId = searchId;
        this.station = station;
        this.route = route;
    }

    public int getSearchId() {
        return searchId;
    }

    public void setSearchId(int searchId) {
        this.searchId = searchId;
    }

    public String getStation() {
        return station;
    }

    public void setStation(String station) {
        this.station = station;
    }

    public String getRoute() {
        return route;
    }

    public void setRoute(String route) {
        this.route = route;
    }

}