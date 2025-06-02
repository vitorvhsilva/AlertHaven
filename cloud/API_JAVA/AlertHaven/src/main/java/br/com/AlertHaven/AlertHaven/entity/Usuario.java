package br.com.AlertHaven.AlertHaven.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "TB_USUARIO")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Usuario {

    @Id
    @Column(name = "id_usuario")
    @GeneratedValue(strategy = GenerationType.UUID)
    private String idUsuario;

    @Column(name = "nome_usuario", nullable = false, length = 255)
    private String nomeUsuario;

    @Column(name = "email_usuario", nullable = false, length = 255)
    private String emailUsuario;

    @Column(name = "senha_usuario", nullable = false, length = 255)
    private String senhaUsuario;

    @Column(name = "cpf_usuario", nullable = false, length = 255)
    private String cpfUsuario;

    @Column(name = "telefone_usuario", nullable = false, length = 255)
    private String telefoneUsuario;

    @Column(name = "data_nascimento", nullable = false)
    private LocalDate dataNascimento;

    @Column(name = "data_criacao_usuario", nullable = false)
    private LocalDateTime dataCriacaoUsuario;

}
