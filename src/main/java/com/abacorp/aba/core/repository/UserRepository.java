package com.abacorp.aba.core.repository;

import com.abacorp.aba.interfaces.strategy.BasicQueryStrategy;
import com.abacorp.aba.model.User;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserRepository implements BasicQueryStrategy<User> {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<User> findAll() {
        return sqlSession.selectList("findAllUser");
    }

    @Override
    public User selectById(Object id) {
        return sqlSession.selectOne("findUserById", (String)id);
    }

    @Override
    public int create(User model) {
        return sqlSession.insert("createUser", model);
    }

    @Override
    public int update(User model) {
        return 0;
    }

    @Override
    public int delete(User model) {
        return 0;
    }
}
