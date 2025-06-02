package br.com.AlertHaven.AlertHaven.controller;

import br.com.AlertHaven.AlertHaven.dto.request.AtualizarUsuarioRequestDTO;
import br.com.AlertHaven.AlertHaven.dto.request.CadastrarUsuarioRequestDTO;
import br.com.AlertHaven.AlertHaven.dto.response.ObterUsuarioResponseDTO;
import br.com.AlertHaven.AlertHaven.entity.Usuario;
import br.com.AlertHaven.AlertHaven.service.UsuarioService;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/usuarios")
@AllArgsConstructor
public class UsuarioController {

    private UsuarioService service;
    private ModelMapper mapper;

    @PostMapping
    public ResponseEntity<ObterUsuarioResponseDTO>cadastrarUsuario(@RequestBody CadastrarUsuarioRequestDTO dto) {
        Usuario usuario = mapper.map(dto, Usuario.class);
        LocalDate dataNasc = LocalDate.of(dto.getAno(), dto.getMes(), dto.getDia());

        ObterUsuarioResponseDTO responseDto = mapper.map(service.cadastrarUsuario(usuario, dataNasc), ObterUsuarioResponseDTO.class);
        return ResponseEntity.status(HttpStatus.CREATED).body(responseDto);
    }

    @GetMapping
    public List<ObterUsuarioResponseDTO> listarUsuarios() {
        List<Usuario> usuarios = service.listarUsuarios();
        return usuarios.stream()
                .map(usuario -> mapper.map(usuario, ObterUsuarioResponseDTO.class))
                .toList();
    }

    @GetMapping("/{id}")
    public ResponseEntity<ObterUsuarioResponseDTO> listarUsuarioPorId(@PathVariable("id") String id){
        Usuario usuario = service.obterUsuarioPorId(id);

        ObterUsuarioResponseDTO responseDto = mapper.map(usuario, ObterUsuarioResponseDTO.class);

        return ResponseEntity.ok(responseDto);
    }

    @PutMapping("/{id}")
    public ResponseEntity<ObterUsuarioResponseDTO> atualizarUsuario(@PathVariable("id") String id, @Valid @RequestBody AtualizarUsuarioRequestDTO dto) {
        Usuario usuario = service.atualizarUsuario(id, dto);

        return ResponseEntity.ok(mapper.map(usuario, ObterUsuarioResponseDTO.class));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletarUsuario(@PathVariable("id") String id) {
        service.deletarUsuarioPorId(id);

        return ResponseEntity.noContent().build();
    }

}
