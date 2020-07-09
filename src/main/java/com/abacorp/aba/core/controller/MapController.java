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
public class MapController {
    private static final Logger logger = LoggerFactory.getLogger(MapController.class);

    @RequestMapping(value = "/maps")
    private ModelAndView kakaoMap() {
        ModelAndView mv = new ModelAndView();

        mv.addObject("offerTypes", OfferType.values());
        mv.addObject("dealTypes", DealType.values());

        mv.setViewName("map/map");

        return mv;
    }
}
