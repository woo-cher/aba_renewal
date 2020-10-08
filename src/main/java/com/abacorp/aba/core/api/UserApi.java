package com.abacorp.aba.core.api;

import com.abacorp.aba.core.service.UserService;
import com.abacorp.aba.model.User;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/apis/users")
@Slf4j
public class UserApi {

    @Autowired
    private UserService service;

    @RequestMapping(value = "/{userId}", method = RequestMethod.GET)
    public boolean checkUserExist(@PathVariable String userId) {
        return service.isExistUser(userId);
    }

    @RequestMapping(value = "/all/{page}", method = RequestMethod.GET)
    public PageInfo<User> findAll(@PathVariable int page) {
        log.info("page param : {}", page);
        return service.findAll(page);
    }
}
