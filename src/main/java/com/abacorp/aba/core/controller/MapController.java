package com.abacorp.aba.core.controller;


import com.abacorp.aba.core.service.MapService;
import com.abacorp.aba.model.type.DealType;
import com.abacorp.aba.model.type.OfferType;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/")
@Slf4j
public class MapController {

    @Autowired
    private ModelAndView mv;

    @Autowired
    private MapService service;

    @RequestMapping("/maps")
    private ModelAndView kakaoMap() {
        mv.addObject("offerTypes", OfferType.values());
        mv.addObject("dealTypes", DealType.values());

        mv.setViewName("map/map");

        return mv;
    }
}
