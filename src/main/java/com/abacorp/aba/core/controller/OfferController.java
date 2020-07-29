package com.abacorp.aba.core.controller;


import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/offers")
@Slf4j
public class OfferController {

    @RequestMapping("/{id}")
    public String show(@PathVariable int id) {
        return "offer/detail";
    }
}
