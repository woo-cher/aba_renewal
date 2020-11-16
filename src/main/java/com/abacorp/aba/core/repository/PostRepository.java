package com.abacorp.aba.core.repository;

import com.abacorp.aba.model.Post;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PostRepository {

    @Autowired
    private SqlSession sqlSession;

    public int insertPost(Post post) {
        return sqlSession.insert("createPost", post);
    }
}
