package com.abacorp.aba.model;

import com.abacorp.aba.core.repository.OfferRepository;
import com.abacorp.aba.core.service.OfferService;
import com.abacorp.aba.model.dto.MapFiltersDto;
import com.abacorp.aba.model.type.DealType;
import com.abacorp.aba.model.type.HeatingType;
import com.abacorp.aba.model.type.OfferStatusType;
import com.abacorp.aba.model.type.OfferType;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.core.Is.is;

@RunWith(SpringRunner.class)
@SpringBootTest
@Slf4j
public class OfferTest {
    private final MapFiltersDto testDto = MapFiltersDto.builder()
            .west("35.15604726758777")
            .east("35.170247905919645")
            .south("128.1038512961487")
            .north("128.13354775681677")
            .belongsTo("호탄동")
            .build();

    private final Offer testOffer = Offer.builder()
                                        .deposit("100").monthlyPrice("33").managementPrice("3")
                                        .type(OfferType.ONE_ROOM).heatingType(HeatingType.ELECT).dealType(DealType.MONTHLY)
                                        .completionYear("2000").status(OfferStatusType.ON)
                                        .offerAddition(
                                                OfferAddition.builder()
                                                        .managementCategory("1,2").optionCategory("1,2")
                                                        .term("0").tenant("무").build()
                                        )
                                        .offerAddress(
                                                OfferAddress.builder()
                                                        .floor("1").jibun("jibun").road("road")
                                                        .belongsTo("belongsTo").ho("ho").nearLocation("near")
                                                        .latitude("0.0").longitude("0.0").door("전화").build()
                                        )
                                        .build();

    @Autowired
    private OfferRepository repository;

    @Autowired
    private OfferService service;

    @Test
    public void getOffersUsingFilters() {
        List<Offer> offers = repository.selectOffersUsingFilter(testDto);
        log.info("offers.. : {}", offers);
    }

    @Test
    public void getOffersByRegion() {
        List<Offer> offers = repository.selectOffersByBelongsTo(testDto);
        log.info("\noffers.. : {}", offers);
   }

   @Test
   @Transactional
   public void curd() throws IOException {
        assertThat(service.createOffer(testOffer), is(1));

        Offer dbOffer = repository.selectOfferById(testOffer.getId());
        dbOffer.setDealer(null);

        assertThat(dbOffer, is(testOffer));

        int generatedId = testOffer.getId();
        assertThat(repository.deleteOfferById(generatedId), is(1));
   }
}
