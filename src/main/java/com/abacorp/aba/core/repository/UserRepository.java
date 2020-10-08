package com.abacorp.aba.core.repository;

import com.abacorp.aba.model.User;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserRepository {

    @Autowired
    private SqlSession sqlSession;

    public List<User> findAll() {
        return sqlSession.selectList("findAllUser");
    }

    public User selectById(Object id) {
        return sqlSession.selectOne("findUserById", (String)id);
    }

    public int create(User model) {
        return sqlSession.insert("createUser", model);
    }

    public int update(User model) {
        return 0;
    }

    public int delete(User model) {
        return 0;
    }
}
