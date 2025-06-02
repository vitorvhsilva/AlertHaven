package br.com.AlertHaven.AlertHaven.repository;

import br.com.AlertHaven.AlertHaven.entity.Localizacao;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LocalizacaoRepository extends JpaRepository<Localizacao, String> {
}
