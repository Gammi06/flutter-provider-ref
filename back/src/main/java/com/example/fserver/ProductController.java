package com.example.fserver;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;

@CrossOrigin
@RequiredArgsConstructor
@RestController
public class ProductController {

    private final ProductRepository productRepository;

    @GetMapping("/api/product")
    public ResponseDto<?> findAll() {
        List<Product> productList = productRepository.findAll();
        return new ResponseDto<>(1, "성공", productList);
    }

    @GetMapping("/api/product/{id}")
    public ResponseDto<?> findById(@PathVariable Integer id) {
        Product product = productRepository.findById(id).orElseThrow(
                () -> new RuntimeException("해당 아이디가 존재하지 않습니다."));
        return new ResponseDto<>(1, "성공", product);
    }

    @PostMapping("api/product")
    public ResponseDto<?> insert(@RequestBody Product productReqDto) {
        Product product = productRepository.save(productReqDto);
        return new ResponseDto<>(1, "생성 성공", product);
    }

    @PutMapping("api/product/{id}")
    public ResponseDto<?> updateById(@PathVariable Integer id, @RequestBody Product productReqDto) {
        productReqDto.setId(id);
        Product product = productRepository.save(productReqDto);
        return new ResponseDto<>(1, "수정 성공", product);
    }

    @DeleteMapping("api/product/{id}")
    public ResponseDto<?> deleteById(@PathVariable Integer id) {
        productRepository.deleteById(id);
        return new ResponseDto<>(1, "삭제 성공", null);
    }

}
