package com.abacorp.aba.core.controller;


import com.abacorp.aba.core.service.AwsS3Service;
import com.abacorp.aba.core.service.MapService;
import com.abacorp.aba.core.service.OfferService;
import com.abacorp.aba.core.utils.SessionUtils;
import com.abacorp.aba.model.mapper.ModelMapper;
import com.abacorp.aba.model.offer.Offer;
import com.abacorp.aba.model.User;
import com.abacorp.aba.model.type.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.ConstraintViolation;
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

    @Autowired
    private AwsS3Service s3Service;

    @RequestMapping(value = "/{offer}", method = RequestMethod.GET)
    public ModelAndView show(@PathVariable int offer, HttpServletRequest request) {
        Offer dbOffer = service.getOfferById(offer);
        HttpSession session = request.getSession();
        boolean isPremium = true;

        User sessionUser = (User) SessionUtils.getObjectValue(session, "sessionUser");

        if (sessionUser == null || sessionUser.getRole().getCode().equals("ROLE_USER")) {
            isPremium = false;
        }

        mv.setViewName("/offer/detail");

        mv.addObject("offer", dbOffer);
        mv.addObject("isPremium", isPremium);

        return mv;
    }

    @RequestMapping("/form")
    public ModelAndView form(@RequestParam(required = false, value = "offerId") Integer offerId,
                             HttpServletRequest request) {
        mv.clear();
        setFormViewAndObject(mv);

        if (offerId != null) {
            log.info("offer(={}) update form initialize", offerId);

            Offer dbOffer = service.getOfferById(offerId);
            log.info("Db offer : {}", dbOffer);

            HttpSession session = request.getSession();
            User sessionUser = (User) session.getAttribute("sessionUser");

            UserRoleType sessionUserRole = sessionUser.getRole();

            if (sessionUserRole.equals(UserRoleType.MASTER) || sessionUserRole.equals(UserRoleType.ADMIN)) {
                // If login user has role 'MASTER' OR 'ADMIN' Nothing to do.
            } else if (!offerService.isOwner(dbOffer.getUser().getUserId(), sessionUser)) {
                mv.clear();
                mv.setViewName("redirect:/auth/denied");

                return mv;
            }

            mv.addObject("isUpdate", true);
            mv.addObject("offer", dbOffer);
        }

        return mv;
    }

    @RequestMapping(value = {"/create", "/update"}, method = RequestMethod.POST)
    public ModelAndView createAndUpdate(@ModelAttribute Offer offer, HttpServletRequest request) throws IOException {
        log.info("offer : {}", offer);
        List<ConstraintViolation<Offer>> cv;
        StringBuffer requestUrl = request.getRequestURL();

        cv = offerService.validateOffer(offer);
        log.info("First : {}", cv);

        if (cv.size() != 0) {
            boolean isUpdate = requestUrl.toString().contains("update");

            setFormViewAndObject(mv);

            if (isUpdate) {
                String offerId = String.valueOf(offer.getId());
                offer.setImageUrls(s3Service.getAllFileUrls(offerId));

                mv.addObject("isUpdate", true);
            }

            mv.addObject("processIndex", offerService.getFormProcessIndex(cv));
            mv.addObject("errors", cv);
            mv.addObject("offer", offer);

            return mv;
        }

        int row = requestUrl.toString().contains("create") ?
                offerService.createOffer(offer) : offerService.updateOffer(offer);

        mv.clear();
        mv.setViewName("redirect:/users/me/my_offer");

        return mv;
    }

    private void setFormViewAndObject(ModelAndView mv) {
        mv.setViewName("/offer/create/form");

        mv.addObject("offerTypes", OfferType.values());
        mv.addObject("dealTypes", DealType.values());
        mv.addObject("options", OptionType.values());
        mv.addObject("heatingTypes", HeatingType.values());
        mv.addObject("manages", ManagementCategoryType.values());
    }
}
