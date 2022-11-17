package com.example.fserver;

import java.util.Arrays;
import java.util.List;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SetupDB {

    // @Profile("dev")
    @Bean
    public CommandLineRunner run(ProductRepository productRepository) {
        return (args) -> {
            Product p1 = Product.builder().name("바나나").price(1000).build();
            Product p2 = Product.builder().name("딸기").price(3000).build();
            Product p3 = Product.builder().name("수박").price(4000).build();
            Product p4 = Product.builder().name("참외").price(2000).build();

            List<Product> products = Arrays.asList(p1, p2, p3, p4);
            productRepository.saveAll(products);
        };
    }
}
