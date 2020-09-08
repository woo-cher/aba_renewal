package com.abacorp.aba.core.controller;

import com.abacorp.aba.core.service.OfferRequestService;
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

import java.sql.SQLException;
import java.util.List;

@Controller
@RequestMapping("/requests")
@Slf4j
public class OfferRequestController {

    @Autowired
    private ModelAndView mv;

    @Autowired
    private OfferRequestService service;

    @RequestMapping(value = "/create/form")
    public ModelAndView createForm() {
        mv.addObject("conditions", RequiredConditionType.values());
        mv.addObject("offerTypes", OfferType.values());
        mv.addObject("dealTypes", DealType.values());

        mv.setViewName("request/create_form");

        return mv;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public ModelAndView create(@ModelAttribute OfferRequest offerRequest) throws SQLException {
        log.info("offerRequest : {}", offerRequest);

        int row = service.createRequest(offerRequest);

        if(row == 0) {
            throw new SQLException("OfferRequest insert error.. row : 0");
        }

        return createForm();
    }

    @RequestMapping(value = "/{request}", method = RequestMethod.GET)
    public ModelAndView read(@PathVariable(value = "request") int requestId) {
        OfferRequest offerRequest = service.selectRequestById(requestId);

        mv.addObject("request", offerRequest);
        mv.setViewName("request/detail");


        return mv;
    }

    @RequestMapping(value = "/all", method = RequestMethod.GET)
    public ModelAndView readAll() {
        List<OfferRequest> offerRequests = service.selectRequests();

        mv.addObject("requests", offerRequests);
        mv.addObject("isMy", false);
        mv.setViewName("request/list");

        return mv;
    }

    @RequestMapping(value = "/{request}", method = RequestMethod.DELETE)
    public void delete(@PathVariable(value = "request") int requestId) {
        service.deleteRequestById(requestId);

        // Do something about ModelAndView
    }

    @RequestMapping("/my/certified")
    public String meCertified() {
        return "request/my_certified";
    }

    @RequestMapping(value = "/my", method = RequestMethod.POST)
    public ModelAndView myOfferRequests(String phone) {
        String phoneWithDash = phone.replaceAll(",", "-");

        List<OfferRequest> myOfferRequests = service.selectRequestByPhone(phoneWithDash);

        mv.addObject("requests", myOfferRequests);
        mv.addObject("isMy", true);
        mv.setViewName("request/list");

        return mv;
    }
}
