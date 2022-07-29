package com.koelsa.sw.repository;

import com.koelsa.sw.jpa.CustomOAuth2User;
import com.koelsa.sw.jpa.Role;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CustomOAuthRepository extends JpaRepository<CustomOAuth2User,Integer> {
    Optional<CustomOAuth2User> findByEmail(String email);
    Optional<CustomOAuth2User> findByuserId(String email);

    Page<CustomOAuth2User> findAllByNameLike(Pageable pageable, String name);

    @Query("select (user) from CustomOAuth2User user where user.email = ?1")
    CustomOAuth2User findByEmail2(String email);
}
