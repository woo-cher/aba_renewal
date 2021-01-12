package com.abacorp.aba.validator;

import com.abacorp.aba.model.offer.NormalRentalOffer;
import com.abacorp.aba.model.offer.Offer;
import com.abacorp.aba.model.offer.OfferAddition;
import com.abacorp.aba.model.offer.OfferAddress;
import lombok.extern.slf4j.Slf4j;
import org.junit.Before;
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

        log.info("offer : {}", offer);

        for (ConstraintViolation cv : this.constraintViolations) {
            log.info("cv : {}", cv);
        }
    }

    @Test
    public void childOfferValidationWithParent() {
        OfferAddress address = OfferAddress.builder()
                .floor("")
                .build();

        OfferAddition addition = OfferAddition.builder()
                .optionTypes(null)
                .build();

        NormalRentalOffer child = NormalRentalOffer.builder()
                .offerAddress(address)
                .offerAddition(addition)
                .build();

        this.constraintViolations = new ArrayList<>(validator.validate(child));

        for (ConstraintViolation cv : this.constraintViolations) {
            log.info("cv : {}", cv);
        }
    }
}
