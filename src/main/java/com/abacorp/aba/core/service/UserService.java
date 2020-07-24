package com.abacorp.aba.core.service;


import com.abacorp.aba.core.repository.UserRepository;
import com.abacorp.aba.model.User;
import com.abacorp.aba.security.CustomUserDetails;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class UserService implements UserDetailsService {
    private static final Logger logger = LoggerFactory.getLogger(UserService.class);

    @Autowired
    private UserRepository repository;

    @Override
    public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
        User user = this.repository.selectById(userId);

        if(user == null) {
            throw new UsernameNotFoundException("Not Found User : " + userId);
        }

        logger.info("find db user : {}", user);

        return new CustomUserDetails(user);
    }

    public int createUser(User user) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

        String natural = user.getPassword();
        user.setPassword(encoder.encode(natural));

        user.setPhone(user.getPhone().replaceAll(",", ""));
        user.setAgentPhone(user.getAgentPhone().replaceAll(",", ""));
        user.setEmail(user.getEmail().replaceAll(",", "@"));
        user.setExtraAddr(user.getExtraAddr().replaceAll(",", " "));

        logger.error("after user : {}", user);

        return this.repository.create(user);
    }

    public boolean isExistUser(String userId) {
        User user = repository.selectById(userId);

        if(user == null) {
            logger.info("user not found at database");
            return false;
        }

        return true;
    }
}
