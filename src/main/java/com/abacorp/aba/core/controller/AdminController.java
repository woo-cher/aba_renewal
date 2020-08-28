package com.abacorp.aba.core.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private ModelAndView mv;

    @RequestMapping("")
    public String index() {
        return "admin/admin";
    }

    @RequestMapping({"/manage/offers", "/manage/offers/{view}"})
    public ModelAndView manageOffer(@PathVariable(required = false) String view) {
        view = view == null ? "offers" : view;

        mv.setViewName("admin/manage/offer/management");
        mv.addObject("view", view);

        return mv;
    }

    @RequestMapping({"/manage/pays", "/manage/pays/{view}"})
    public ModelAndView managePay(@PathVariable(required = false) String view) {
        view = view == null ? "pays" : view;

        mv.setViewName("admin/manage/pay/management");
        mv.addObject("view", view);

        return mv;
    }

    @RequestMapping({"/manage/users", "/manage/users/{view}"})
    public ModelAndView manageUser(@PathVariable(required = false) String view) {
        view = view == null ? "users" : view;

        mv.setViewName("admin/manage/user/management");
        mv.addObject("view", view);

        return mv;
    }
}
