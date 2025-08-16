package com.example.hw.controllers;

import com.example.hw.models.AppInfo;
import com.example.hw.service.HwLogger;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HwController {
    @GetMapping(value = "/", produces = "application/json")
    public AppInfo index() {
        var info = new AppInfo(0.1, "Hello world java web application example with Spring boot, rest and jackson");
        HwLogger.message("called method index from HwController");
        return info;
    }
}

