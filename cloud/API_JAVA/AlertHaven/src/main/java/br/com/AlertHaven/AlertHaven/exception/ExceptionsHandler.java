package br.com.AlertHaven.AlertHaven.exception;

import br.com.AlertHaven.AlertHaven.dto.response.ExceptionDTO;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class ExceptionsHandler {
    @ExceptionHandler(Exception.class)
    private ResponseEntity<ExceptionDTO> handleException(Exception e) {
        ExceptionDTO error = new ExceptionDTO(HttpStatus.BAD_REQUEST.name(), e.getMessage());
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(error);
    }

    @ExceptionHandler(AbrigoNaoEncontradoException.class)
    private ResponseEntity<ExceptionDTO> handleAbrigoNaoEncontradoException(AbrigoNaoEncontradoException e) {
        ExceptionDTO error = new ExceptionDTO(HttpStatus.NOT_FOUND.name(), e.getMessage());
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(error);
    }

    @ExceptionHandler(TipoEmergenciaNaoEncontradoException.class)
    private ResponseEntity<ExceptionDTO> handleTipoEmergenciaNaoEncontradoException(TipoEmergenciaNaoEncontradoException e) {
        ExceptionDTO error = new ExceptionDTO(HttpStatus.NOT_FOUND.name(), e.getMessage());
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(error);
    }

    @ExceptionHandler(UsuarioNaoEncontradoException.class)
    private ResponseEntity<ExceptionDTO> handleUsuarioNaoEncontradoExceptionException(UsuarioNaoEncontradoException e) {
        ExceptionDTO error = new ExceptionDTO(HttpStatus.NOT_FOUND.name(), e.getMessage());
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(error);
    }
}
