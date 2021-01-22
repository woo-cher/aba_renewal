package com.abacorp.aba.core.repository;

import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
@Slf4j
public class AbaRepository {

    @Autowired
    @Qualifier("sqlSessionTemplate")
    protected SqlSession sqlSession;

    @Autowired
    @Qualifier("manageSqlSessionTemplate")
    protected SqlSession manageSqlSession;
}
