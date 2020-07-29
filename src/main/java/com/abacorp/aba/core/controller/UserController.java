package com.abacorp.aba.core.controller;


import com.abacorp.aba.core.service.UserService;
import com.abacorp.aba.model.User;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/users")
@Slf4j
public class UserController {

    @Autowired
    private ModelAndView mv;

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String save(User user, Model model) {
        log.info("USER : {}", user);
        userService.createUser(user);

        return "/user/login";
    }

    @RequestMapping({"/me", "/me/{view}"})
    public ModelAndView me(@PathVariable(required = false) String view) {
        mv.setViewName("me/me");
        mv.addObject("view", view);

        return mv;
    }
}
