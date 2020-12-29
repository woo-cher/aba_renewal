package com.abacorp.aba.core.api;

import com.abacorp.aba.core.service.UserService;
import com.abacorp.aba.core.utils.SessionUtils;
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
    private UserService userService;

    @RequestMapping(value = "/{userId}", method = RequestMethod.GET)
    public boolean checkUserExist(@PathVariable String userId) {
        return userService.isExistUser(userId);
    }

    @RequestMapping(value = "/password/certify", method = RequestMethod.POST)
    public boolean isPasswordMatchWithUser(@RequestBody String password, HttpServletRequest request) {
        log.info("param : {}", password);
        HttpSession session = request.getSession();
        User sessionUser = (User) session.getAttribute("sessionUser");

        return userService.isPasswordMatch(password, sessionUser.getUserId());
    }

    @RequestMapping(value = "/all/{page}", method = RequestMethod.GET)
    public PageInfo<User> findAll(@PathVariable int page) {
        log.info("page param : {}", page);
        return userService.findAll(page);
    }

    @RequestMapping(value = "/general/{page}", method = RequestMethod.GET)
    public PageInfo<User> find(@PathVariable int page) {
        log.info("page param : {}", page);
        return userService.findUserExceptAdmin(page);
    }

    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public PageInfo<User> search(@RequestParam String keyword, @RequestParam int page) {
        return userService.searchUsers(keyword, page);
    }

    @RequestMapping(value = "/{userId}", method = RequestMethod.DELETE)
    public int delete(@PathVariable String userId) {
        log.info("delete target userId : {}", userId);
        return userService.deleteUser(userId);
    }

    @RequestMapping(value = "/filter", method = RequestMethod.POST)
    public PageInfo<User> usersByFilter(@RequestBody UserFilterDto dto) {
        log.info("userDto : {}", dto);
        return userService.getUsersByFilter(dto);
    }

    @RequestMapping(value = "/purchase", method = RequestMethod.GET)
    public void purchase(@RequestParam int packageId, HttpServletRequest request) {
        HttpSession session = request.getSession();
        User sessionUser = (User) SessionUtils.getObjectValue(session, "sessionUser");

        userService.purchasePackage(sessionUser, packageId);

        // Update SessionUser's point & role
        sessionUser = userService.findByUserId(sessionUser.getUserId());
        session.setAttribute("sessionUser", sessionUser);
    }
}
