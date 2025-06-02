package br.com.AlertHaven.AlertHaven.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class AtualizarUsuarioRequestDTO {
    @NotBlank(message = "O nome do usuário não pode ficar em branco")
    private String nomeUsuario;

    @NotBlank(message = "O email do usuário não pode ficar em branco")
    private String emailUsuario;

    @NotBlank(message = "A senha do usuário não pode ficar em branco")
    private String senhaUsuario;

    @NotBlank(message = "O cpf do usuário não pode ficar em branco")
    @Size(min = 11, max = 11, message = "O cpf do usuário deve ter 11 digitos")
    private String cpfUsuario;

    @NotBlank(message = "O telefone do usuário não pode ficar em branco")
    private String telefoneUsuario;

    @NotNull(message = "O dia de nascimento do usuário não pode ficar em branco")
    private int dia;

    @NotNull(message = "O mes de nascimento do usuário não pode ficar em branco")
    private int mes;

    @NotNull(message = "O ano de nascimento do usuário não pode ficar em branco")
    private int ano;
}
