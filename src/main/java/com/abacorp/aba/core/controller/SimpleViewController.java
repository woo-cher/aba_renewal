package com.abacorp.aba.core.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/")
@Slf4j
public class SimpleViewController {

    @Autowired
    private ModelAndView mv;

    @RequestMapping("/")
    private String index() {
        return "index";
    }

    @RequestMapping("/intro")
    private String intro() {
        return "intro";
    }

    @RequestMapping("/guide")
    private String guide() {
        return "guide";
    }

    @RequestMapping("/agree/{index}")
    private ModelAndView servicePolicy(@PathVariable int index) {

        mv.addObject("viewIndex", index);
        mv.setViewName("agree/agree_view");

        return mv;
    }
}
