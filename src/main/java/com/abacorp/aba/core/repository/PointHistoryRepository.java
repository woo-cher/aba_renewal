package com.abacorp.aba.core.repository;

import com.abacorp.aba.model.PointHistory;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PointHistoryRepository {

    @Autowired
    private SqlSession sqlSession;

    public int insertPointHistory(PointHistory pointHistory) {
        return sqlSession.insert("insertPointHistory", pointHistory);
    }
}
