package com.abacorp.aba.core.controller;

import com.abacorp.aba.model.type.OfferType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.Arrays;
import java.util.List;

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

    @RequestMapping(value = "/maps")
    private ModelAndView kakaoMap() {
        ModelAndView mv = new ModelAndView();

        mv.addObject("offerTypes", OfferType.values());
        mv.setViewName("map/map");

        return mv;
    }
}
