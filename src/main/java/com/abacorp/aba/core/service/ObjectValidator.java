package com.abacorp.aba.core.service;

import com.abacorp.aba.model.mapper.ModelMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import java.util.List;

@Service
@Validated
@Slf4j
public class ObjectValidator {

    public List<FieldError> validate(@Valid ModelMapper model, BindingResult bindingResult) {
        if(bindingResult.hasErrors()) {
            List<FieldError> errors = bindingResult.getFieldErrors();

            return errors;
        }

        return null;
    }
}
