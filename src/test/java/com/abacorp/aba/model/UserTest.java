package com.abacorp.aba.model;

import com.abacorp.aba.core.repository.UserRepository;
import com.abacorp.aba.core.service.UserService;
import com.abacorp.aba.model.type.UserRoleType;
import com.abacorp.aba.model.type.UserType;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import static org.hamcrest.core.Is.is;
import static org.junit.Assert.*;

@RunWith(SpringRunner.class)
@SpringBootTest
public class UserTest {
    public static final User TEST_USER = User.builder()
            .userId("TEST_USER")
            .password("test")
            .phone("0101111222")
            .type(UserType.MASTER)
            .agentPhone("01011112222")
            .email("test@test.com")
            .extraAddr("extraAddr")
            .role(UserRoleType.USER)
            .build();

    @Autowired
    private UserService service;

    @Autowired
    private UserRepository repository;

    @Test
    @Transactional
    public void cr() {
        int row = service.createUser(TEST_USER);
        assertThat(row, is(1));

        User dbUser = repository.selectById(TEST_USER.getUserId());
        assertNotNull(dbUser);
        assertThat(TEST_USER, is(dbUser));
    }

    @Test
    public void checkForUserExist() {
        String noneUserId = "none";
        User dbUser = repository.selectById(noneUserId);

        assertNull(dbUser);
    }
}
