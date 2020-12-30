package com.abacorp.aba.core.repository;

import com.abacorp.aba.model.Membership;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository
public class MembershipRepository {

    @Autowired
    private SqlSession sqlSession;

    public int insertMembership(Membership membership) {
        return sqlSession.insert("insertMembership", membership);
    }

    public int createExpiredMembershipEvent(Map<String, Object> map) {
        return sqlSession.update("createExpiredEventScheduler", map);
    }

    // 가장 최근 것으로 갖고 옴
    public Membership isExistUsingMembership(String userId) {
        return sqlSession.selectOne("selectExistUsingMembership", userId);
    }
}
