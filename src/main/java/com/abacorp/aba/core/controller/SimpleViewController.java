package com.abacorp.aba.core.controller;

import com.abacorp.aba.model.type.DealType;
import com.abacorp.aba.model.type.OfferType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/")
public class SimpleViewController {
    private static final Logger logger = LoggerFactory.getLogger(SimpleViewController.class);

    @RequestMapping(value = "/")
    private String index() {
        return "index";
    }

    @RequestMapping(value = "/intro")
    private String intro() {
        return "intro";
    }

    @RequestMapping(value = "/guide")
    private String guide() {
        return "guide";
    }
}
