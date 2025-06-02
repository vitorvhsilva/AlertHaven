package br.com.AlertHaven.AlertHaven.dto.response;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ExceptionDTO {
    private String erro;
    private String mensagem;
}
