package com.abacorp.aba.core.controller;


import com.abacorp.aba.core.service.UserService;
import com.abacorp.aba.model.User;
import com.abacorp.aba.model.type.UserType;
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

    @RequestMapping("/form")
    public ModelAndView form() {
        String[] keys = {"이용약관", "개인정보취급 방침", "위치기반서비스 이용약관", "책임한계 및 법적고지"};
        String[] values = {"provision", "personal_info", "location_based", "responsibility"};

        mv.addObject("keys", keys);
        mv.addObject("values", values);
        mv.addObject("userTypes", UserType.values());

        mv.setViewName("user/form");

        return mv;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String save(User user) {
        log.info("USER : {}", user);
        userService.createUser(user);

        return "/user/login";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String update(User user) {
        log.warn("UPDATE USER : {}", user);
        userService.updateUser(user);

        return "redirect:/users/me/my_aba";
    }

    @RequestMapping({"/me", "/me/{view}"})
    public ModelAndView me(@PathVariable(required = false) String view) {
        mv.setViewName("me/me");
        mv.addObject("view", view);

        return mv;
    }
}
