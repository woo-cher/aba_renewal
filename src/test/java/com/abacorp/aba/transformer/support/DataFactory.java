package com.abacorp.aba.transformer.support;

import com.abacorp.aba.model.mapper.TypeMapper;
import com.abacorp.aba.model.offer.TemporaryAbaOffer;
import com.abacorp.aba.model.type.FacilityCostCategoryType;
import com.abacorp.aba.model.type.ManagementCategoryType;
import com.abacorp.aba.model.type.OptionType;
import com.abacorp.aba.transformer.NormalRentalTransformer;
import com.abacorp.aba.transformer.NormalSaleTransformer;
import com.abacorp.aba.transformer.OfficeRentalTransformer;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;

@Slf4j
@Component
public class DataFactory <T extends TypeMapper> {

    @Autowired
    @Qualifier("normalRental")
    private TransformStrategy<NormalRentalTransformer> normalRentalStrategy;

    @Autowired
    @Qualifier("normalSale")
    private TransformStrategy<NormalSaleTransformer> normalSaleStrategy;

    @Autowired
    @Qualifier("officeRental")
    private TransformStrategy<OfficeRentalTransformer> officeRentalStrategy;

    public TransformStrategy<? extends OfferTransformTemplate> getTransformer(TemporaryAbaOffer abaOffer) {
        String gubunCode = abaOffer.getGubun();
        String etc1 = abaOffer.getEtc1();

        if (gubunCode.equals("57")) {
            if (etc1.equals("1")) {
                return normalSaleStrategy; // 주택인데 매매면
            }

            return normalRentalStrategy; // 주택인데 월,전세면
        } else if (gubunCode.equals("61") || gubunCode.equals("75")) { // 원룸 또는 투. 쓰리룸 이면
            return normalRentalStrategy;
        } else if (gubunCode.equals("65") || gubunCode.equals("66")) { // 건물(원룸) 또는 건물(상가) 이면
            return normalSaleStrategy;
        } else if (gubunCode.equals("5") || gubunCode.equals("7")) { // 상가 또는 사무실이면
            return officeRentalStrategy;
        }

        return null;
    }

    public List<? extends TypeMapper> getTypeArray(Class<T> clazz) {
        if (clazz.equals(OptionType.class)) {
            return Arrays.asList(OptionType.values());
        } else if (clazz.equals(ManagementCategoryType.class)) {
            return Arrays.asList( ManagementCategoryType.values());
        } else {
            return Arrays.asList(FacilityCostCategoryType.values());
        }
    }
}
