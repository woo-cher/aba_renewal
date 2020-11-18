package com.abacorp.aba.core.repository;

import com.abacorp.aba.model.Post;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class PostRepository {

    @Autowired
    private SqlSession sqlSession;

    public int insertPost(Post post) {
        return sqlSession.insert("createPost", post);
    }

    public List<Post> selectPosts() {
        return sqlSession.selectList("selectPosts");
    }

    public Post selectPostById(int id) {
        return sqlSession.selectOne("selectPostById", id);
    }

    public int updatePostHits(int id) {
        return sqlSession.update("updatePostHits", id);
    }

    public int updatePost(Post post) {
        return sqlSession.update("updatePost", post);
    }

    public int deletePost(int id) {
        return sqlSession.delete("deletePost", id);
    }
}
