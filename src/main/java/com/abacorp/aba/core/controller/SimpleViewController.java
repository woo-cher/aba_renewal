package com.abacorp.aba.core.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/")
public class SimpleViewController {
    private static final Logger logger = LoggerFactory.getLogger(SimpleViewController.class);

    @Autowired
    private ModelAndView mv;

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

    @RequestMapping(value = "/agree/{index}")
    private ModelAndView servicePolicy(@PathVariable int index) {

        mv.addObject("viewIndex", index);
        mv.setViewName("agree/agree_view");

        return mv;
    }
}
