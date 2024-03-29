package com.abacorp.aba.core.service;

import com.abacorp.aba.core.repository.OfferRequestRepository;
import com.abacorp.aba.model.offer.OfferRequest;
import com.abacorp.aba.model.dto.RequestFilterDto;
import com.abacorp.aba.model.type.OfferRequestType;
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
        String clientWanted = offerRequest.getDemand();

        if (clientWanted.isEmpty()) {
            offerRequest.setDemand("좋은 집 추천해주세요!");
        }

        String phone = offerRequest.getPhone().replaceAll(",", "-");
        offerRequest.setPhone(phone);

        String addr = offerRequest.getLocation().replaceAll(",", ", ");
        offerRequest.setLocation(addr);

        return repository.createOfferRequest(offerRequest);
    }

    /**
     * TODO) Custom 타입에 해당하는 List 추출 로직에 중복을 처리할 필요가 있다.
     *
     * @see MapService line 57 ~
     */
    @Transactional
    public OfferRequest selectRequestById(int id) {
        repository.updateOfferRequestHit(id);

        OfferRequest offerRequest = repository.findOfferRequestById(id);

        convertIndexToCustomType(offerRequest);

        return offerRequest;
    }

    public List<OfferRequest> selectRequests(RequestFilterDto filterDto) {
        List<OfferRequest> offerRequests = repository.findOfferRequests(filterDto);

        for(OfferRequest request : offerRequests) {
            convertIndexToCustomType(request);
        }

        return offerRequests;
    }

    public int deleteRequestById(int id) {
        return repository.deleteOfferRequest(id);
    }

    public List<OfferRequest> selectRequestByPhone(String phone) {
        return repository.findOfferRequestByPhone(phone);
    }

    private void convertIndexToCustomType(OfferRequest offerRequest) {
        RequiredConditionType[] types = RequiredConditionType.values();
        OfferRequestType[] offerTypes = OfferRequestType.values();

        List<RequiredConditionType> typeList = new ArrayList<>();
        List<OfferRequestType> offerTypeList = new ArrayList<>();

        int i;

        for (String indexStr : offerRequest.getRequiredConditions().split(",")) { // 1, 2, 3
            i = Integer.parseInt(indexStr);
            typeList.add(types[i]);
        }

        for (String indexStr : offerRequest.getOfferRequestTypes().split(",")) { // 1, 2, 3
            i = Integer.parseInt(indexStr);
            offerTypeList.add(offerTypes[i]);
        }

        offerRequest.setConditionTypeList(typeList);
        offerRequest.setOfferTypeList(offerTypeList);
    }
}
