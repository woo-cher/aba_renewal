package com.abacorp.aba.core.service;

import com.abacorp.aba.core.repository.OfferRequestRepository;
import com.abacorp.aba.model.OfferRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class OfferRequestService {

    @Autowired
    OfferRequestRepository repository;

    public int createRequest(OfferRequest offerRequest) {
        String phone = offerRequest.getPhone().replaceAll(",", "-");
        offerRequest.setPhone(phone);

        String addr = offerRequest.getLocation().replaceAll(",", "");
        offerRequest.setLocation(addr);

        return repository.createOfferRequest(offerRequest);
    }

    public OfferRequest selectRequestById(int id) {
        return repository.findOfferRequestById(id);
    }

    public List<OfferRequest> selectRequests() {
        return repository.findOfferRequests();
    }

    public int deleteRequestById(int id) {
        return repository.deleteOfferRequest(id);
    }
}
