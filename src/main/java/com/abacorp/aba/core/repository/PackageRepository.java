package com.abacorp.aba.core.repository;

import com.abacorp.aba.model.Package;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
@Slf4j
public class PackageRepository {

    @Autowired
    private SqlSession sqlSession;

    public Package selectPackageById(int id) {
        return sqlSession.selectOne("selectPackageById", id);
    }
}
