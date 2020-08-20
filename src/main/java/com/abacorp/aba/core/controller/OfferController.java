package com.abacorp.aba.core.controller;


import com.abacorp.aba.core.service.AwsS3Service;
import com.abacorp.aba.core.service.MapService;
import com.abacorp.aba.model.Offer;
import com.abacorp.aba.model.type.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/offers")
@Slf4j
public class OfferController {

    @Autowired
    private ModelAndView mv;

    @Autowired
    private MapService service;

    @Autowired
    private AwsS3Service s3Service;

    @RequestMapping("/{id}")
    public ModelAndView show(@PathVariable int id) {
        Offer offer = service.getOfferById(id);

        mv.setViewName("/offer/detail");
        mv.addObject("offer", offer);

        return mv;
    }

    // 관리자가 아니면, 매물 등록이 안되므로 차후 /admin/** 로 옮겨야 한다.
    @RequestMapping("/create/form")
    public ModelAndView createView() {
        mv.setViewName("/offer/create/form");

        mv.addObject("offerTypes", OfferType.values());
        mv.addObject("dealTypes", DealType.values());
        mv.addObject("options", OptionType.values());
        mv.addObject("heatingTypes", HeatingType.values());
        mv.addObject("manages", ManagementCategoryType.values());

        return mv;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String create(@ModelAttribute Offer offer) {
        log.info("Model of Offer : {}", offer);

        // required `create` flow.

        return "/offer/create/form";
    }
}
