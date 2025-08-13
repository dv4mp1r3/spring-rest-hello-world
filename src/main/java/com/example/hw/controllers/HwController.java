package com.example.hw.controllers;

import com.example.hw.models.AppInfo;
import com.example.hw.service.HwLogger;
import com.fasterxml.jackson.core.JsonProcessingException;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
public class HwController {
    @GetMapping(value = "/", produces = "application/json")
    public String index() throws JsonProcessingException {
        var info = new AppInfo(0.1, "Hello world java web application example with Spring boot, rest and jackson");
        HwLogger.message("called method index from HwController");
        ObjectMapper mapper = new ObjectMapper();
        try {
            String jsonString = mapper.writeValueAsString(info);
            HwLogger.message(String.format("Object %s will be return from the endpoint", jsonString));
            return jsonString;
        } catch (JsonProcessingException e) {
            HwLogger.error(e.getMessage());
            throw e;
        }
    }
}
