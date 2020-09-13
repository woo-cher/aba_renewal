package com.abacorp.aba.core.service;

import com.abacorp.aba.core.repository.OfferRequestRepository;
import com.abacorp.aba.model.OfferRequest;
import com.abacorp.aba.model.type.OfferType;
import com.abacorp.aba.model.type.RequiredConditionType;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
public class OfferRequestService {

    @Autowired
    private OfferRequestRepository repository;

    public int createRequest(OfferRequest offerRequest) {
        String phone = offerRequest.getPhone().replaceAll(",", "-");
        offerRequest.setPhone(phone);

        String addr = offerRequest.getLocation().replaceAll(",", "");
        offerRequest.setLocation(addr);

        return repository.createOfferRequest(offerRequest);
    }

    /**
     * TODO) Custom 타입에 해당하는 List 추출 로직에 중복을 처리할 필요가 있다.
     * @see MapService line 57 ~
     */
    @Transactional
    public OfferRequest selectRequestById(int id) {
        repository.updateOfferRequestHit(id);

        OfferRequest offerRequest = repository.findOfferRequestById(id);

        RequiredConditionType[] types = RequiredConditionType.values();
        OfferType[] offerTypes = OfferType.values();

        List<RequiredConditionType> typeList = new ArrayList<>();
        List<OfferType> offerTypeList = new ArrayList<>();

        int i;

        for(String indexStr : offerRequest.getRequiredConditions().split(",")) { // 1, 2, 3
            i = Integer.parseInt(indexStr);
            typeList.add(types[i]);
        }

        for(String indexStr : offerRequest.getOfferRequestTypes().split(",")) { // 1, 2, 3
            i = Integer.parseInt(indexStr);
            offerTypeList.add(offerTypes[i]);
        }

        offerRequest.setConditionTypeList(typeList);
        offerRequest.setOfferTypeList(offerTypeList);

        return offerRequest;
    }

    public List<OfferRequest> selectRequests() {
        return repository.findOfferRequests();
    }

    public int deleteRequestById(int id) {
        return repository.deleteOfferRequest(id);
    }

    public List<OfferRequest> selectRequestByPhone(String phone) {
        return repository.findOfferRequestByPhone(phone);
    }
}
