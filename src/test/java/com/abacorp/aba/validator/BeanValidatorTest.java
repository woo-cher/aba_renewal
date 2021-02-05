package com.abacorp.aba.validator;

import com.abacorp.aba.core.service.OfferService;
import com.abacorp.aba.factory.OfferGroupFactory;
import com.abacorp.aba.model.offer.Offer;
import com.abacorp.aba.model.offer.OfferAddition;
import com.abacorp.aba.model.offer.OfferAddress;
import com.abacorp.aba.model.offer.group.BasicGroup;
import com.abacorp.aba.model.offer.group.GroupMapper;
import com.abacorp.aba.model.type.DealType;
import com.abacorp.aba.model.type.HeatingType;
import com.abacorp.aba.model.type.OfferType;
import lombok.extern.slf4j.Slf4j;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import java.util.ArrayList;
import java.util.List;

@RunWith(JUnit4.class)
@Slf4j
public class BeanValidatorTest {

    private Validator validator;
    private List<ConstraintViolation<Offer>> constraintViolations;

    @Before
    public void setup() {
         this.validator = Validation.buildDefaultValidatorFactory().getValidator();
    }

    @Test
    public void offerValidation() {
        OfferAddress address = OfferAddress.builder()
                .floor("")
                .build();

        OfferAddition addition = OfferAddition.builder()
                .optionTypes(null)
                .build();

        Offer offer = Offer.builder()
                .deposit("")
                .offerAddress(address)
                .offerAddition(addition)
                .build();

        this.constraintViolations = new ArrayList<>(validator.validate(offer));
        this.constraintViolations.addAll(validator.validate(offer, BasicGroup.class));

        log.info("offer : {}", offer);

        for (ConstraintViolation cv : this.constraintViolations) {
            log.info("cv : {}", cv);
        }
    }

    @Test
    public void validateModule() {
        Offer offer = Offer.builder()
                .type(OfferType.ONE_ROOM)
                .dealType(DealType.SALE)
                .inquiryTel("010-1234-1234")
                .interest("3")
                .heatingType(HeatingType.OIL)
                .build();

        OfferService service = new OfferService();
        OfferGroupFactory factory = new OfferGroupFactory();

        Class<? extends GroupMapper> groupClazz = factory.groupCreator(offer);

        this.constraintViolations = service.validateOffer(offer);

        log.info("{}", this.constraintViolations.size());
        for (ConstraintViolation<Offer> cv : this.constraintViolations) {
            log.info("cv : {}", cv);
        }
    }

    private void printConstraintViolation(List<ConstraintViolation<Offer>> constraintViolations) {
        if (constraintViolations.size() != 0) {
            for (ConstraintViolation<Offer> cv : this.constraintViolations) {
                log.info("cv : {}", cv);
            }
        } else {
            log.error("constraintViolations size is '0'");
        }
    }
}
