package com.abacorp.aba.core.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/")
public class PostController {
    private static final Logger logger = LoggerFactory.getLogger(PostController.class);

    @Autowired
    private ModelAndView mv;

    @RequestMapping("/posts")
    private String index() {
        return "post/post";
    }

    @RequestMapping(value = "/posts/{id}", method = RequestMethod.GET)
    private ModelAndView show(@PathVariable int id) {
        mv.setViewName("post/post_detail");

        return mv;
    }
}
