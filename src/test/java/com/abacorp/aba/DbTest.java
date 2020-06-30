package com.abacorp.aba;

import static junit.framework.TestCase.assertNotNull;
import static org.junit.Assert.*;

import com.abacorp.aba.core.repository.UserRepository;
import com.abacorp.aba.model.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest
public class DbTest {
    private static final Logger logger = LoggerFactory.getLogger(DbTest.class);

    @Autowired
    private DataSource dataSource;

    @Autowired
    private UserRepository repository;

    @Test
    public void dataSource() throws SQLException {
        logger.warn("Datasource : {}", dataSource.getConnection());
        assertNotNull(dataSource.getConnection());
    }

    @Test
    public void findAllUser() {
        List<User> users = repository.findAll();
        logger.info("size : {}", users.size());
        assertNotNull(users);
    }
}
