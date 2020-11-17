package com.abacorp.aba.core.api;

import com.abacorp.aba.core.service.PostService;
import com.abacorp.aba.model.Post;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/apis/posts")
@Slf4j
public class PostApi {
    private final int POSTS_PER_PAGE = 4;

    @Autowired
    private PostService postService;

    @RequestMapping(value = "/all", method = RequestMethod.GET)
    public PageInfo<Post> posts(@RequestParam(value = "page") int page) {
        return PageHelper.startPage(page, POSTS_PER_PAGE).doSelectPageInfo(
                () -> postService.getPosts()
        );
    }
}
