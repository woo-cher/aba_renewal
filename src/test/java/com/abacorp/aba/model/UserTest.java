package com.abacorp.aba.model;

import static org.hamcrest.core.Is.is;
import static org.junit.Assert.*;

import com.abacorp.aba.core.repository.UserRepository;
import com.abacorp.aba.core.service.UserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class UserTest {
    public static final User TEST_USER = User.builder()
            .userId("test")
            .password("test")
            .role("USER")
            .build();

    @Autowired
    private UserService service;

    @Autowired
    private UserRepository repository;

    @Test
    public void cr() {
        int row = service.createUser(TEST_USER);
        assertThat(row, is(1));

        User dbUser = repository.selectById(TEST_USER.getUserId());
        assertNotNull(dbUser);
        assertThat(TEST_USER, is(dbUser));
    }
}