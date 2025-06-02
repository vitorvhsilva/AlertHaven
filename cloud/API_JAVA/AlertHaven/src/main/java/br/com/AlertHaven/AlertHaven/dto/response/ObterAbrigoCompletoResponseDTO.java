package br.com.AlertHaven.AlertHaven.dto.response;

import lombok.Data;

import java.util.List;

@Data
public class ObterAbrigoCompletoResponseDTO {

    private String idAbrigo;
    private String nomeAbrigo;
    private String capacidadeSuportadaAbrigo;
    private String emailAbrigo;
    private LocalizacaoDTO localizacao;
    private List<String> tiposEmergencias;
}
