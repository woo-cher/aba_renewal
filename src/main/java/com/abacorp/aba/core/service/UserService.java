package com.abacorp.aba.core.service;


import com.abacorp.aba.core.repository.MembershipRepository;
import com.abacorp.aba.core.repository.ProductRepository;
import com.abacorp.aba.core.repository.PointHistoryRepository;
import com.abacorp.aba.core.repository.UserRepository;
import com.abacorp.aba.model.Membership;
import com.abacorp.aba.model.Product;
import com.abacorp.aba.model.PointHistory;
import com.abacorp.aba.model.User;
import com.abacorp.aba.model.dto.UserFilterDto;
import com.abacorp.aba.model.type.UserRoleType;
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

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

@Service
@Slf4j
public class UserService implements UserDetailsService {
    private final int USERS_PER_PAGE = 3;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private ProductRepository packageRepository;

    @Autowired
    private MembershipRepository membershipRepository;

    @Autowired
    private PointHistoryRepository pointHistoryRepository;

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

    /**
     *  FLOW)
     *   1. 맴버십 DB 데이터 추가
     *   2. 사용자 DB 포인트 갱신, ROLE 컬럼 변경 처리
     *   3. 포인트 사용 내역 히스토리 DB 데이터 추가
     *   4. 만료기한에 대한 이벤트 스케줄러 추가 -> ROLE 컬럼 `PREMIUM -> USER` 로 변경 처리
     */
    @Transactional
    public void purchaseProduct(User sessionUser, int productId) {
        Product dbProduct = packageRepository.selectProductById(productId);
        log.info("Selected Product object : {}", dbProduct);

        Membership usingMembership = membershipRepository.selectRecentlyPurchase(sessionUser.getUserId());
        boolean isExistUsingMembership = usingMembership != null;

        log.info("Is membership user ? : {}", isExistUsingMembership);

        if(usingMembership != null) {
            log.info("Recently product : {}", usingMembership.getProduct());
        }

        // Insert membership
        Membership membership = Membership.builder()
                .product(dbProduct)
                .user(sessionUser)
                .build();

        log.info("Membership object : {}", membership);

        if (isExistUsingMembership) {
            Timestamp startPoint = usingMembership.getExpiredAt();

            membership.setCreatedAt(startPoint);
            membership.setExpiredAt(startPoint);

            membershipRepository.appendMembership(membership);
        } else {
            membershipRepository.insertMembership(membership);
        }

        // Update user role & point
        updateUserPoint(sessionUser.getUserId(), sessionUser.getPoint() - dbProduct.getPrice());

        Map<String, Object> map = new HashMap<>();

        map.put("userId", sessionUser.getUserId());
        map.put("role", UserRoleType.PREMIUM);

        userRepository.updateUserRole(map);

        // Insert point history
        PointHistory pointHistory = PointHistory.builder()
                .user(sessionUser)
                .product(dbProduct)
                .build();

        pointHistoryRepository.insertPointHistory(pointHistory);

        // Create event scheduler
        map.put("period", dbProduct.getPeriod());

        if (isExistUsingMembership) {
            map.put("expiredAt", usingMembership.getExpiredAt());
            membershipRepository.updateExpiredMemebershipEvent(map);
        } else {
            membershipRepository.createExpiredMembershipEvent(map);
        }
    }
}
