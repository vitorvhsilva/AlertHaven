package br.com.AlertHaven.AlertHaven.repository;

import br.com.AlertHaven.AlertHaven.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, String> {
}
