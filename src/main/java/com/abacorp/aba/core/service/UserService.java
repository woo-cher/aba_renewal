package com.abacorp.aba.core.service;


import com.abacorp.aba.core.repository.UserRepository;
import com.abacorp.aba.model.User;
import com.abacorp.aba.model.type.UserType;
import com.abacorp.aba.security.CustomUserDetails;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class UserService implements UserDetailsService {

    @Autowired
    private UserRepository repository;

    @Override
    public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
        User user = this.repository.selectById(userId);

        if(user == null) {
            throw new UsernameNotFoundException("Not Found User : " + userId);
        }

        log.info("find db user : {}", user);

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

        if(user.getType().equals(UserType.OWNER)) {
            user.setAgentPhone(null);
            user.setAgentNumber(null);
            user.setAgentName(null);
            user.setAgentLeader(null);
        }

        return this.repository.create(user);
    }

    public boolean isExistUser(String userId) {
        User user = repository.selectById(userId);

        if(user == null) {
            log.info("user not found at database");
            return false;
        }

        return true;
    }
}
