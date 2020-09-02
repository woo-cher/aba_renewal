package com.abacorp.aba.core.controller;

import com.abacorp.aba.core.repository.OfferRequestRepository;
import com.abacorp.aba.model.OfferRequest;
import com.abacorp.aba.model.type.DealType;
import com.abacorp.aba.model.type.OfferType;
import com.abacorp.aba.model.type.RequiredConditionType;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/requests")
@Slf4j
public class OfferRequestController {

    @Autowired
    private ModelAndView mv;

    @Autowired
    private OfferRequestRepository repository;

    @RequestMapping(value = "/create/form")
    public ModelAndView createForm() {
        mv.addObject("conditions", RequiredConditionType.values());
        mv.addObject("offerTypes", OfferType.values());
        mv.addObject("dealTypes", DealType.values());

        mv.setViewName("request/create_form");

        return mv;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public void create(@ModelAttribute OfferRequest offerRequest) {

    }

    @RequestMapping(value = "/{request}", method = RequestMethod.GET)
    public void read(@PathVariable(value = "request") int requestId) {

    }

    @RequestMapping(value = "/{request}", method = RequestMethod.DELETE)
    public void delete(@PathVariable(value = "request") int requestId) {

    }
}
