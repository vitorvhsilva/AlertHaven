package br.com.AlertHaven.AlertHaven.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Table(name = "TB_ABRIGO")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Abrigo {

    @Id
    @Column(name = "id_abrigo")
    @GeneratedValue(strategy = GenerationType.UUID)
    private String id;

    @Column(name = "nome_abrigo", nullable = false, length = 255)
    private String nomeAbrigo;

    @Column(name = "capacidade_suportada_abrigo", nullable = false, length = 10)
    private int capacidadeSuportadaAbrigo;

    @Column(name = "email_abrigo", nullable = false, length = 50)
    private String emailAbrigo;

    @OneToOne(mappedBy = "abrigo", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Localizacao localizacao;

    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(name = "TB_ABRIGO_TIPO_EMERGENCIA",
            joinColumns = @JoinColumn(name = "id_abrigo"),
            inverseJoinColumns = @JoinColumn(name = "id_tipo_emergencia")
            )
    private List<TipoEmergencia> tipoEmergencias;
}
