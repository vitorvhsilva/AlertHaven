package br.com.AlertHaven.AlertHaven.dto.request;

import lombok.Data;

@Data
public class AtualizarAbrigoRequestDTO {
    private String nomeAbrigo;
    private String emailAbrigo;
    private int capacidadeSuportadaAbrigo;
}
