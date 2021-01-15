package com.abacorp.aba.transformer.support;

import com.abacorp.aba.model.mapper.TypeMapper;
import com.abacorp.aba.model.type.FacilityCostCategoryType;
import com.abacorp.aba.model.type.ManagementCategoryType;
import com.abacorp.aba.model.type.OptionType;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;

@Slf4j
@Component
public class DataFactory <T extends TypeMapper> {

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
