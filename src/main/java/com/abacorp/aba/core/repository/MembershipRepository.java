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

    public int appendMembership(Membership membership) {
        return sqlSession.insert("appendMembership", membership);
    }

    public int createExpiredMembershipEvent(Map<String, Object> map) {
        return sqlSession.update("createExpiredEventScheduler", map);
    }

    public Membership selectRecentlyPurchase(String userId) {
        return sqlSession.selectOne("selectRecentlyPurchaseMemberShip", userId);
    }

    public Membership selectUsingMembership(String userId) {
        return sqlSession.selectOne("selectUsingMemberShip", userId);
    }

    public int updateExpiredMemebershipEvent(Map<String, Object> map) {
        return sqlSession.update("updateExpiredEventScheduler", map);
    }
}
