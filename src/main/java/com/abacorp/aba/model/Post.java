package com.abacorp.aba.model;

import com.abacorp.aba.model.mapper.ModelMapper;
import com.abacorp.aba.model.type.PostType;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Data
@Builder
@EqualsAndHashCode
@ToString
public class Post extends ModelMapper {
    private User register;
    @NotBlank(message = "제목을 입력하세요")
    private String title;
    @NotBlank(message = "내용을 입력하세요")
    private String contents;
    @NotNull(message = "게시글 유형을 선택하세요")
    private PostType postType;
    @Builder.Default
    private int hits = 0;
}
