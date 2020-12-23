package com.abacorp.aba.core.service;


import com.abacorp.aba.core.repository.PaymentRepository;
import com.abacorp.aba.core.repository.UserRepository;
import com.abacorp.aba.model.User;
import com.abacorp.aba.model.dto.UserFilterDto;
import com.abacorp.aba.model.type.UserType;
import com.abacorp.aba.security.CustomUserDetails;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

@Service
@Slf4j
public class UserService implements UserDetailsService {
    private final int USERS_PER_PAGE = 3;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PaymentRepository paymentRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
        User user = this.userRepository.selectById(userId);

        if(user == null) {
            throw new UsernameNotFoundException("Not Found User : " + userId);
        }

        log.info("find db user : {}", user);

        return new CustomUserDetails(user);
    }

    public int createUser(User user) {
        return this.userRepository.create(getConvertedUser(user));
    }

    public PageInfo<User> findAll(int page) {
        return PageHelper.startPage(page, USERS_PER_PAGE).doSelectPageInfo(
                () -> userRepository.findAll()
        );
    }

    public PageInfo<User> findUserExceptAdmin(int page) {
        return PageHelper.startPage(page, USERS_PER_PAGE).doSelectPageInfo(
                () -> userRepository.selectUsersExceptAdmin()
        );
    }

    public PageInfo<User> searchUsers(String keyword, int page) {
        return PageHelper.startPage(page, USERS_PER_PAGE).doSelectPageInfo(
                () -> userRepository.selectUsersWithKeyword(keyword)
        );
    }

    public boolean isExistUser(String userId) {
        User user = userRepository.selectById(userId);

        if(user == null) {
            log.info("user not found at database");
            return false;
        }

        return true;
    }

    public boolean isPasswordMatch(String actualPassword, String sessionUserId) {
        String dbUserPassword = userRepository.selectById(sessionUserId).getPassword();
        return passwordEncoder.matches(actualPassword, dbUserPassword);
    }

    public User findByUserId(String userId) {
        return userRepository.selectById(userId);
    }

    public int updateUser(User user) {
        return userRepository.update(getConvertedUser(user));
    }

    private User getConvertedUser(User user) {
        String natural = user.getPassword();
        user.setPassword(passwordEncoder.encode(natural));

        user.setPhone(user.getPhone().replaceAll(",", "-"));
        user.setAgentPhone(user.getAgentPhone().replaceAll(",", "-"));
        user.setEmail(user.getEmail().replaceAll(",", "@"));
        user.setExtraAddr(user.getExtraAddr().replaceAll(",", " "));

        if(user.getType().equals(UserType.OWNER)) {
            user.setAgentPhone(null);
            user.setAgentNumber(null);
            user.setAgentName(null);
            user.setAgentLeader(null);
        }

        return user;
    }

    public int deleteUser(String userId) {
        return userRepository.delete(userId);
    }

    public PageInfo<User> getUsersByFilter(UserFilterDto dto) {
        return PageHelper.startPage(dto.getPage(), USERS_PER_PAGE).doSelectPageInfo(
                () -> userRepository.selectUsersByFilter(dto)
        );
    }

    @Transactional
    public int updateUserPoint(String userId, int point) {
        Map<String, Object> map = new HashMap<>();
        map.put("userId", userId);
        map.put("point", point);

        return userRepository.updatePoint(map);
    }
}
