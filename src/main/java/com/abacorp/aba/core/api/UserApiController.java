package com.abacorp.aba.core.api;

import com.abacorp.aba.core.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/users")
public class UserApiController {
    private static final Logger logger = LoggerFactory.getLogger(UserApiController.class);

    @Autowired
    private UserService service;

    @RequestMapping(value = "/{userId}", method = RequestMethod.GET)
    public boolean checkUserExist(@PathVariable String userId) {
        return service.isExistUser(userId);
    }
}
