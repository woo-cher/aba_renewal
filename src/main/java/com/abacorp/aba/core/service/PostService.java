package com.abacorp.aba.core.service;

import com.abacorp.aba.core.repository.PostRepository;
import com.abacorp.aba.model.Post;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Slf4j
public class PostService {

    @Autowired
    private PostRepository postRepository;

    public int createPost(Post post) {
        return postRepository.insertPost(post);
    }

    public List<Post> getPosts() {
        return postRepository.selectPosts();
    }

    @Transactional
    public Post getPostById(int id) {
        log.info("update hit row : {}", postRepository.updatePostHits(id));

        return postRepository.selectPostById(id);
    }

    public int updatePost(Post post) {
        return postRepository.updatePost(post);
    }

    public int deletePost(int id) {
        return postRepository.deletePost(id);
    }
}
