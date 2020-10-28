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
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.io.IOException;
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

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public ModelAndView show(@PathVariable int id) {
        Offer offer = service.getOfferById(id);

        mv.setViewName("/offer/detail");
        mv.addObject("offer", offer);

        return mv;
    }

    @RequestMapping("/form")
    public ModelAndView form(@RequestParam(required = false, value = "offerId") Integer offerId) {
        mv.clear();
        mv.setViewName("/offer/create/form");

        mv.addObject("offerTypes", OfferType.values());
        mv.addObject("dealTypes", DealType.values());
        mv.addObject("options", OptionType.values());
        mv.addObject("heatingTypes", HeatingType.values());
        mv.addObject("manages", ManagementCategoryType.values());

        if(offerId != null) {
            log.info("Offer update form initialize ID : {}", offerId);
            mv.addObject("isUpdate", true);

            Offer offer = service.getOfferById(offerId);
            log.info("Db offer : {}", offer);
            mv.addObject("offer", offer);
        }

        return mv;
    }

    @RequestMapping(value = {"/create", "/update"}, method = RequestMethod.POST)
    public ModelAndView createAndUpdate(@ModelAttribute @Valid Offer offer,
                                        BindingResult bindingResult, HttpServletRequest request) throws IOException {
        if(!offer.getFiles().get(0).getOriginalFilename().isEmpty()) {
            log.info("size : {}", offer.getFiles().size());
            for(MultipartFile file : offer.getFiles()) {
                log.info("\tname : {}", file.getOriginalFilename());
            }
        }

        log.info("offer : {}", offer);

        if(bindingResult.hasErrors()) {
            List<FieldError> errors = bindingResult.getFieldErrors();
            offerService.getFormProcessIndex(errors);

            mv = form(null);

            mv.addObject("processIndex", offerService.getFormProcessIndex(errors));
            mv.addObject("errors", errors);
            mv.addObject("offer", offer);

            return mv;
        }

        StringBuffer requestUrl = request.getRequestURL();
        log.info("URL : {}", requestUrl); // http://localhost:8080/offers/update

        int row = requestUrl.toString().contains("create") ?
                offerService.createOffer(offer) : offerService.updateOffer(offer);

        mv.setViewName("admin/admin");

        return mv;
    }
}
