package br.com.AlertHaven.AlertHaven.dto.response;

import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
public class ObterUsuarioResponseDTO {
    private String idUsuario;
    private String nomeUsuario;
    private String emailUsuario;
    private String senhaUsuario;
    private String cpfUsuario;
    private String telefoneUsuario;
    private LocalDate dataNascimento;
    private LocalDateTime dataCriacaoUsuario;
}
