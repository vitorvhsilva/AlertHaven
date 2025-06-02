package br.com.AlertHaven.AlertHaven.repository;

import br.com.AlertHaven.AlertHaven.entity.Abrigo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AbrigoRepository extends JpaRepository<Abrigo, String> {
}
