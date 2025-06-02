package br.com.AlertHaven.AlertHaven.dto.response;

import lombok.Data;

@Data
public class LocalizacaoDTO {
    private String idLocalizacao;
    private String identificacaoUnicaAbrigo;
    private String latitudeAbrigo;
    private String longitudeAbrigo;
    private String ruaAbrigo;
}
