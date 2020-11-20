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

    public int create(User user) {
        return sqlSession.insert("createUser", user);
    }

    public int update(User user) {
        return sqlSession.update("updateUser", user);
    }

    public int delete(String userId) {
        return sqlSession.delete("deleteUser", userId);
    }

    public List<User> findUsersExceptAdmin() {
        return sqlSession.selectList("findUserExceptAdmin");
    }

    public List<User> findUserWithKeyword(String keyword) {
        return sqlSession.selectList("searchUserByKeyword", keyword);
    }
}
