package com.abacorp.aba.core.controller;


import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/auth")
@Slf4j
public class AuthController {

    @Autowired
    private ModelAndView mv;

    @RequestMapping("/login")
    public String login(HttpServletRequest request) {
        String referrer = request.getHeader("Referer");

        if (!referrer.contains("/auth/login")) {
            request.getSession().setAttribute("prevPage", referrer);
        }

        return "user/login";
    }

    @RequestMapping("/denied")
    public String denied() {
        return "error/denied";
    }
}
