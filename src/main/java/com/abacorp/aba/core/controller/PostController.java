package com.abacorp.aba.core.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/")
@Slf4j
public class PostController {

    @Autowired
    private ModelAndView mv;

    @RequestMapping("/posts")
    private String index() {
        return "post/post";
    }

    @RequestMapping(value = "/posts/form", method = RequestMethod.GET)
    private ModelAndView form() {
        mv.setViewName("post/form");

        return mv;
    }

    @RequestMapping(value = "/posts/{id}", method = RequestMethod.GET)
    private ModelAndView show(@PathVariable int id) {
        mv.setViewName("post/post_detail");

        return mv;
    }

    @RequestMapping(value = "/posts/create", method = RequestMethod.GET)
    private ModelAndView create(@PathVariable int id) {
        mv.setViewName("post/post_detail");

        return mv;
    }
}
