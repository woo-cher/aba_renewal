package com.abacorp.aba.core.controller;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/offers")
public class OfferController {
    private static final Logger logger = LoggerFactory.getLogger(OfferController.class);

    @RequestMapping("/{id}")
    public String show(@PathVariable int id) {
        return "offer/detail";
    }
}
