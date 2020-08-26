package com.abacorp.aba.validator;

import com.abacorp.aba.model.Offer;
import com.abacorp.aba.model.OfferAddition;
import com.abacorp.aba.model.OfferAddress;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import java.util.ArrayList;
import java.util.List;

@RunWith(JUnit4.class)
@Slf4j
public class BeanValidatorTest {

    @Test
    public void offerValidation() {
        Validator validator = Validation.buildDefaultValidatorFactory().getValidator();

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

        List<ConstraintViolation<Offer>> constraintViolations = new ArrayList<>(validator.validate(offer));

        log.info("offer : {}", offer);

        for(ConstraintViolation cv : constraintViolations) {
            log.info("cv : {}", cv);
        }
    }
}
