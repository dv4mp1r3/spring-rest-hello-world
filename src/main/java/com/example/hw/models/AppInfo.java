package com.example.hw.models;

public class AppInfo {

    private double version;

    private String about;

    public AppInfo(){}

    public AppInfo(double version, String about) {
        this.version = version;
        this.about = about;
    }

    public String getAbout() {
        return about;
    }

    public double getVersion() {
        return version;
    }
}
