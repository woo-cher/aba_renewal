package com.abacorp.aba.core.repository;

import com.abacorp.aba.model.PointHistory;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
public class PointHistoryRepository {

    @Autowired
    @Qualifier("sqlSessionTemplate")
    private SqlSessionTemplate sqlSession;

    public int insertPointHistory(PointHistory pointHistory) {
        return sqlSession.insert("insertPointHistory", pointHistory);
    }
}
