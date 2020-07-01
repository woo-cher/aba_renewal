package com.abacorp.aba.core.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/")
public class HomeController {
    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

    @RequestMapping(value = "/home")
    private String home() {
        logger.info("Welcome home.jsp !!");

        return "home";
    }

    @RequestMapping(value = "/")
    private String index() {
        return "index";
    }

    @RequestMapping(value = "/intro")
    private String intro() {
        return "intro";
    }
}
