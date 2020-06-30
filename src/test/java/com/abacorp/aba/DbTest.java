package com.abacorp.aba;

import static junit.framework.TestCase.assertNotNull;
import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.sql.DataSource;
import java.sql.SQLException;

@RunWith(SpringRunner.class)
@SpringBootTest
public class DbTest {
    private static final Logger logger = LoggerFactory.getLogger(DbTest.class);

    @Autowired
    private DataSource dataSource;

    @Test
    public void dataSource() throws SQLException {
        logger.warn("Datasource : {}", dataSource.getConnection());
        assertNotNull(dataSource.getConnection());
    }
}
