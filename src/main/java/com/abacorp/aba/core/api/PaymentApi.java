package com.abacorp.aba.core.api;

import com.abacorp.aba.core.service.PaymentService;
import com.abacorp.aba.core.utils.SessionUtils;
import com.abacorp.aba.model.Payment;
import com.abacorp.aba.model.User;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@RestController
@RequestMapping("/apis/payments")
@Slf4j
public class PaymentApi {

    @Autowired
    private PaymentService paymentService;

    @RequestMapping(value = "/charge", method = RequestMethod.POST)
    public int chargePoint(@RequestBody Payment payment, HttpServletRequest request) {
        HttpSession session = request.getSession();
        User sessionUser = (User) SessionUtils.getObjectValue(session, "sessionUser");

        payment.setUser(sessionUser);
        log.info("Payment : {}", payment);

        int row = paymentService.createPayment(payment);
        session.setAttribute("sessionUser", payment.getUser());

        return row;
    }
}
