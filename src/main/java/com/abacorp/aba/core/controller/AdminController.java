package com.abacorp.aba.core.controller;

import com.abacorp.aba.core.service.UserService;
import com.abacorp.aba.model.User;
import com.abacorp.aba.model.type.DealType;
import com.abacorp.aba.model.type.OfferType;
import com.abacorp.aba.model.type.OptionType;
import com.abacorp.aba.model.type.UserType;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private ModelAndView mv;

    @Autowired
    private UserService userService;

    @RequestMapping("")
    public String index() {
        return "admin/admin";
    }

    @RequestMapping({"/offers", "/offers/{view}"})
    public ModelAndView manageOffer(@PathVariable(required = false) String view) {
        view = view == null ? "offers" : view;

        mv.setViewName("admin/manage/offer/management");
        mv.addObject("view", view);
        mv.addObject("offerTypes", OfferType.values());
        mv.addObject("dealTypes", DealType.values());
        mv.addObject("options", OptionType.values());

        return mv;
    }

    @RequestMapping({"/pays", "/pays/{view}"})
    public ModelAndView managePay(@PathVariable(required = false) String view) {
        view = view == null ? "pays" : view;

        mv.setViewName("admin/manage/pay/management");
        mv.addObject("view", view);

        return mv;
    }

    @RequestMapping({"/users", "/users/{view}"})
    public ModelAndView manageUser(@PathVariable(required = false) String view,
                                   @RequestParam(required = false) String id) {
        if(id != null) {
            log.info("RequestParam userId exist : {}", id);
            mv.addObject("user", userService.findByUserId(id));
        }

        view = view == null ? "users" : view;

        mv.setViewName("admin/manage/user/management");
        mv.addObject("view", view);
        mv.addObject("userTypes", UserType.values());

        return mv;
    }
}
