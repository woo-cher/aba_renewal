package com.abacorp.aba.model;

import com.abacorp.aba.model.mapper.ModelMapper;
import lombok.*;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
public class Product extends ModelMapper {
    private String name;
    private int price;
    private int period;

    @Override
    public String toString() {
        return "Product{" +
                "name='" + name + '\'' +
                ", price=" + price +
                ", period=" + period +
                ", id=" + id +
                '}';
    }
}
