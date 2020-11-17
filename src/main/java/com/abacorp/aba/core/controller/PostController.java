package com.abacorp.aba.core.controller;

import com.abacorp.aba.core.service.PostService;
import com.abacorp.aba.model.Offer;
import com.abacorp.aba.model.Post;
import com.abacorp.aba.model.User;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;

@Controller
@RequestMapping("/")
@Slf4j
public class PostController {

    @Autowired
    private ModelAndView mv;

    @Autowired
    private PostService postService;

    @RequestMapping("/posts")
    private String index() {
        return "post/post";
    }

    @RequestMapping(value = "/posts/form", method = RequestMethod.GET)
    private ModelAndView form() {
        mv.clear();
        mv.setViewName("post/form");

        return mv;
    }

    @RequestMapping(value = "/posts/{id}", method = RequestMethod.GET)
    private ModelAndView show(@PathVariable int id) {
        Post post = postService.getPostById(id);
        log.info("dbPost: {}", post);

        mv.setViewName("post/post_detail");
        mv.addObject("post", post);

        return mv;
    }

    @RequestMapping(value = "/posts/create", method = RequestMethod.POST)
    private ModelAndView create(@ModelAttribute @Valid Post post, BindingResult bindingResult, HttpServletRequest request) {
        log.info("post : {}", post);

        if (bindingResult.hasErrors()) {
            List<FieldError> errors = bindingResult.getFieldErrors();

            mv.addObject("errors", errors);
            mv.addObject("post", post);

            return mv;
        }

        HttpSession session = request.getSession();
        User register = (User) session.getAttribute("sessionUser");

        post.setRegister(register);

        postService.createPost(post);

        mv.setViewName("redirect:/posts");

        return mv;
    }
}
