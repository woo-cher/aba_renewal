package com.abacorp.aba.core.service;

import com.abacorp.aba.core.repository.PaymentRepository;
import com.abacorp.aba.model.Payment;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Slf4j
public class PaymentService {

    @Autowired
    private PaymentRepository repository;

    @Autowired
    private UserService userService;

    @Transactional
    public int createPayment(Payment payment) {
        int row;

        repository.insertPayment(payment);
        row = userService.updateUserPoint(payment.getUser().getUserId(), payment.getAmount());

        int previousPoint = payment.getUser().getPoint();
        int chargedPoint = payment.getAmount();

        payment.getUser().setPoint(previousPoint + chargedPoint);

        return row;
    }
}
