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

    @RequestMapping("/register")
    public ModelAndView register() {
        String[] keys = {"이용약관", "개인정보취급 방침", "위치기반서비스 이용약관", "책임한계 및 법적고지"};
        String[] values = {"provision", "personal_info", "location_based", "responsibility"};

        mv.addObject("keys", keys);
        mv.addObject("values", values);
        mv.addObject("userTypes", UserType.values());

        mv.setViewName("user/register");

        return mv;
    }

    @RequestMapping("/denied")
    public String denied() {
        return "error/denied";
    }
}
