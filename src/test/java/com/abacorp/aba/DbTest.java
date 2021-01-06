package com.abacorp.aba;

import com.abacorp.aba.core.repository.UserRepository;
import com.abacorp.aba.model.User;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.util.List;

import static junit.framework.TestCase.assertNotNull;

@RunWith(SpringRunner.class)
@SpringBootTest
@Slf4j
public class DbTest {

    @Autowired
    private DataSource dataSource;

    @Autowired
    private UserRepository repository;

    @Test
    public void dataSource() throws SQLException {
        log.warn("Datasource : {}", dataSource.getConnection());
        assertNotNull(dataSource.getConnection());
    }

    @Test
    public void findAllUser() {
        List<User> users = repository.findAll();
        log.info("size : {}", users.size());
        assertNotNull(users);
    }
}
