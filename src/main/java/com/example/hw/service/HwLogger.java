package com.example.hw.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
public class HwLogger {
    private static final Logger logger = LoggerFactory.getLogger(HwLogger.class);

    public static void message(String msg) {
        logger.info(msg);
    }

    public static void error(String err) {
        logger.error(err);
    }
}
