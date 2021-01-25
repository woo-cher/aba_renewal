package com.abacorp.aba.core.repository;

import com.abacorp.aba.model.User;
import com.abacorp.aba.model.dto.UserFilterDto;
import com.github.pagehelper.PageInfo;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class UserRepository extends AbaRepository {

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

    public List<User> selectUsersExceptAdmin() {
        return sqlSession.selectList("selectUserExceptAdmin");
    }

    public List<User> selectUsersWithKeyword(String keyword) {
        return sqlSession.selectList("searchUsersByKeyword", keyword);
    }

    public List<User> selectUsersByFilter(UserFilterDto dto) {
        return sqlSession.selectList("selectUsersByFilter", dto);
    }

    public int updatePoint(Map<String, Object> map) {
        return sqlSession.update("updateUserPoint", map);
    }

    public int updateUserRole(Map<String, Object> map) {
        return sqlSession.update("updateUserRole", map);
    }
}
