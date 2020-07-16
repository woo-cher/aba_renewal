package com.abacorp.aba.core.controller;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/auth")
public class AuthController {
    private static final Logger logger = LoggerFactory.getLogger(AuthController.class);

    @Autowired
    private ModelAndView mv;

    @RequestMapping("/login")
    public String login() {
        return "user/login";
    }

    @RequestMapping("/register")
    public ModelAndView register() {
        String[] keys = {"이용약관", "개인정보취급 방침", "위치기반서비스 이용약관", "책임한계 및 법적고지"};
        String[] values = {"provision", "personal_info", "location_based", "responsibility"};

        mv.addObject("keys", keys);
        mv.addObject("values", values);

        mv.setViewName("user/register");

        return mv;
    }

    @RequestMapping("/denied")
    public String denied() {
        return "error/denied";
    }
}
