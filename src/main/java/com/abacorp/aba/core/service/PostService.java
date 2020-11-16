package com.abacorp.aba.core.service;

import com.abacorp.aba.core.repository.PostRepository;
import com.abacorp.aba.model.Post;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class PostService {

    @Autowired
    private PostRepository postRepository;

    public int createPost(Post post) {
        return postRepository.insertPost(post);
    }
}
