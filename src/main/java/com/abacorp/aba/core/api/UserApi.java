package com.abacorp.aba.core.api;

import com.abacorp.aba.core.service.UserService;
import com.abacorp.aba.model.User;
import com.abacorp.aba.model.dto.UserFilterDto;
import com.github.pagehelper.PageInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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

    @RequestMapping(value = "/password/certify", method = RequestMethod.POST)
    public boolean isPasswordMatchWithUser(@RequestBody String password, HttpServletRequest request) {
        log.info("param : {}", password);
        HttpSession session = request.getSession();
        User sessionUser = (User) session.getAttribute("sessionUser");

        return service.isPasswordMatch(password, sessionUser.getUserId());
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
        return service.searchUsers(keyword, page);
    }

    @RequestMapping(value = "/{userId}", method = RequestMethod.DELETE)
    public int delete(@PathVariable String userId) {
        log.info("delete target userId : {}", userId);
        return service.deleteUser(userId);
    }

    @RequestMapping(value = "/filter", method = RequestMethod.POST)
    public PageInfo<User> usersByFilter(@RequestBody UserFilterDto dto) {
        return service.getUsersByFilter(dto);
    }
}
