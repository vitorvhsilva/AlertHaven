package br.com.AlertHaven.AlertHaven.repository;

import br.com.AlertHaven.AlertHaven.entity.TipoEmergencia;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TipoEmergenciaRepository extends JpaRepository<TipoEmergencia, Integer> {
}
