package com.abacorp.aba.core.api;

import com.abacorp.aba.core.service.UserService;
import com.abacorp.aba.model.User;
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

    @RequestMapping(value = "/general/{page}", method = RequestMethod.GET)
    public PageInfo<User> find(@PathVariable int page) {
        log.info("page param : {}", page);
        return service.findUserExceptAdmin(page);
    }

    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public PageInfo<User> search(@RequestParam String keyword, @RequestParam int page) {
        return service.searchUser(keyword, page);
    }

    @RequestMapping(value = "/{userId}", method = RequestMethod.DELETE)
    public int delete(@PathVariable String userId) {
        log.info("delete target userId : {}", userId);
        return service.deleteUser(userId);
    }
}
