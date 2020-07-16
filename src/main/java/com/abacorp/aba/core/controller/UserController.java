package com.abacorp.aba.core.controller;


import com.abacorp.aba.core.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/users")
public class UserController {
    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private ModelAndView mv;

    @Autowired
    private UserService userService;

    @RequestMapping("/create")
    public String create() {
        return "";
    }

    @RequestMapping({"/me", "/me/{view}"})
    public ModelAndView me(@PathVariable(required = false) String view) {
        mv.setViewName("me/me");
        mv.addObject("view", view);

        return mv;
    }
}
