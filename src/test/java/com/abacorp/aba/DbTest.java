package com.abacorp.aba;

import com.abacorp.aba.core.repository.TransformerRepository;
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
    @Qualifier("dataSource")
    private DataSource dataSource;

    @Autowired
    @Qualifier("manageDataSource")
    private DataSource manageDataSource;

    @Autowired
    private UserRepository repository;

    @Autowired
    private TransformerRepository repository2;

    @Test
    public void dataSource() throws SQLException {
        log.warn("Datasource : {}", dataSource.getConnection());
        assertNotNull(dataSource.getConnection());
        log.warn("Datasource2 : {}", manageDataSource.getConnection());
        assertNotNull(manageDataSource.getConnection());
    }

    @Test
    public void getByDb() {
        log.info("user using basic dataSource : {}", repository.selectById("test"));
        log.info("abaOffer using 2nd dataSource : {}", repository2.selectAbaOffers());
    }

    @Test
    public void findAllUser() {
        List<User> users = repository.findAll();
        log.info("size : {}", users.size());
        assertNotNull(users);
    }
}
