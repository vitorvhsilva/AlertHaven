package br.com.AlertHaven.AlertHaven.dto.response;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class AtualizarAbrigoResponseDTO {
    @NotBlank(message = "O nome do abrigo não pode ficar em branco")
    private String nomeAbrigo;

    @NotBlank(message = "O email do abrigo não pode ficar em brannco")
    private String emailAbrigo;

    @NotBlank(message = "A capacidade do abrigo não pode ficar em branco")
    private int capacidadeSuportadaAbrigo;

}
