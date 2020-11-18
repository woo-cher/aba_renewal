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
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;

@Controller
@RequestMapping("/posts")
@Slf4j
public class PostController {

    @Autowired
    private ModelAndView mv;

    @Autowired
    private PostService postService;

    @RequestMapping("")
    private String index() {
        return "post/post";
    }

    @RequestMapping(value = "/form", method = RequestMethod.GET)
    private ModelAndView form(@RequestParam(required = false, value = "postId") Integer postId) {
        mv.clear();
        mv.setViewName("post/form");

        if (postId != null) {
            Post dbPost = postService.getPostById(postId);

            mv.addObject("post", dbPost);
            mv.addObject("isUpdate", true);
        }

        return mv;
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    private ModelAndView show(@PathVariable int id) {
        Post post = postService.getPostById(id);
        log.info("dbPost: {}", post);

        mv.setViewName("post/post_detail");
        mv.addObject("post", post);

        return mv;
    }

    @RequestMapping(value = {"/create", "/update"}, method = RequestMethod.POST)
    private ModelAndView create(@ModelAttribute @Valid Post post, BindingResult bindingResult, HttpServletRequest request) {
        log.info("post : {}", post);

        StringBuffer requestUrl = request.getRequestURL();
        boolean isUpdate = requestUrl.toString().contains("update");

        if (bindingResult.hasErrors()) {
            List<FieldError> errors = bindingResult.getFieldErrors();

            mv.addObject("errors", errors);
            mv.addObject("post", post);
            mv.addObject("isUpdate", isUpdate);

            return mv;
        }

        HttpSession session = request.getSession();
        User register = (User) session.getAttribute("sessionUser");

        post.setRegister(register);

        int row = isUpdate ? postService.updatePost(post) : postService.createPost(post);

        mv.clear();
        mv.setViewName("redirect:/posts");

        return mv;
    }
}
