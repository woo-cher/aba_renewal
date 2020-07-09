package com.abacorp.aba.core.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/")
public class PostController {
    private static final Logger logger = LoggerFactory.getLogger(PostController.class);

    @RequestMapping(value = "/posts")
    private String index() {
        return "post/post";
    }

    @RequestMapping(value = "/posts/{id}", method = RequestMethod.GET)
    private ModelAndView show(@PathVariable int id) {
        ModelAndView mv = new ModelAndView();

        mv.setViewName("post/post_detail");

        return mv;
    }
}
