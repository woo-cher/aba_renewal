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
import org.springframework.stereotype.Service;

@Service
public class UserService implements UserDetailsService {
    private static final Logger logger = LoggerFactory.getLogger(UserService.class);

    @Autowired
    private UserRepository repository;

    @Override
    public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
        User user = this.repository.selectById(userId);
        logger.info("find db user : {}", user);

        return new CustomUserDetails(user);
    }

    public User findById(String userId) {
        return this.repository.selectById(userId);
    }
}
