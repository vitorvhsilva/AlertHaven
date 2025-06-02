package br.com.AlertHaven.AlertHaven.service;

import br.com.AlertHaven.AlertHaven.dto.request.AtualizarUsuarioRequestDTO;
import br.com.AlertHaven.AlertHaven.entity.Usuario;
import br.com.AlertHaven.AlertHaven.exception.UsuarioNaoEncontradoException;
import br.com.AlertHaven.AlertHaven.repository.UsuarioRepository;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
@AllArgsConstructor
public class UsuarioService {

    private UsuarioRepository repository;

    public Usuario cadastrarUsuario(Usuario usuario, LocalDate dataNascimento) {
        usuario.setDataNascimento(dataNascimento);
        usuario.setDataCriacaoUsuario(LocalDateTime.now());

        return repository.save(usuario);
    }

    public List<Usuario> listarUsuarios() {
        return repository.findAll();
    }

    public Usuario obterUsuarioPorId(String id) {
        return repository.findById(id).orElseThrow(() -> new UsuarioNaoEncontradoException("Usuario não encontrado"));
    }

    public void deletarUsuarioPorId(String id) {
        repository.deleteById(id);
    }

    @Transactional
    public Usuario atualizarUsuario(String id, @Valid AtualizarUsuarioRequestDTO dto) {
        Usuario usuario = obterUsuarioPorId(id);

        usuario.setNomeUsuario(dto.getNomeUsuario());
        usuario.setEmailUsuario(dto.getEmailUsuario());
        usuario.setSenhaUsuario(dto.getSenhaUsuario());
        usuario.setCpfUsuario(dto.getCpfUsuario());
        usuario.setTelefoneUsuario(dto.getTelefoneUsuario());

        return usuario;
    }
}
