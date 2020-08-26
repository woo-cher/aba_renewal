package com.abacorp.aba.core.controller;


import com.abacorp.aba.core.service.MapService;
import com.abacorp.aba.core.service.OfferService;
import com.abacorp.aba.model.Offer;
import com.abacorp.aba.model.type.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
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
    private OfferService offerService;

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
    public ModelAndView create(@ModelAttribute @Valid Offer offer, BindingResult bindingResult) {
        log.info("offer : {}", offer);

        if(bindingResult.hasErrors()) {
            List<FieldError> errors = bindingResult.getFieldErrors();
            offerService.getCreateProcessIndex(errors);

            mv = createView();
            mv.setViewName("/offer/create/form");
            mv.addObject("processIndex", offerService.getCreateProcessIndex(errors));
            mv.addObject("errors", errors);
            mv.addObject("offer", offer);

            return mv;
        }

        offerService.createOffer(offer);
        mv.setViewName("/");

        return mv;
    }
}
