package com.example.fserver;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class ResponseDto<T> {
    private Integer code;
    private String msg;
    private T data;

    @Builder
    public ResponseDto(Integer code, String msg, T data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }

}