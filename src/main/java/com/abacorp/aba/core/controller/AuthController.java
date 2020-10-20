package com.abacorp.aba.core.controller;


import com.abacorp.aba.model.type.UserType;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/auth")
@Slf4j
public class AuthController {

    @Autowired
    private ModelAndView mv;

    @RequestMapping("/login")
    public String login() {
        return "user/login";
    }

    @RequestMapping("/denied")
    public String denied() {
        return "error/denied";
    }
}
