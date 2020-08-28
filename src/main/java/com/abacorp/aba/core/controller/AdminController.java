package com.abacorp.aba.core.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {

    @RequestMapping("")
    public String index() {
        return "admin/admin";
    }

    @RequestMapping("/manage/offer")
    public String manageOffer() {
        return "admin/offer_management";
    }

    @RequestMapping("/manage/pay")
    public String managePay() {
        return "admin/pay_management";
    }

    @RequestMapping("/manage/user")
    public String manageUser() {
        return "admin/user_management";
    }
}
