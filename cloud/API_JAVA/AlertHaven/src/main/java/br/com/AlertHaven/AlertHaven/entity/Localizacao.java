package br.com.AlertHaven.AlertHaven.entity;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "TB_localizacao")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Localizacao {

    @Id
    @Column(name = "id_localizacao")
    @GeneratedValue(strategy = GenerationType.UUID)
    private String idLocalizacao;

    @Column(name = "identificacao_unica_abrigo")
    private String identificacaoUnicaAbrigo;

    @Column(name = "latitude_abrigo")
    private String latitudeAbrigo;

    @Column(name = "longitude_abrigo")
    private String longitudeAbrigo;

    @Column(name = "rua_abrigo")
    private String ruaAbrigo;

    @ManyToOne
    @JoinColumn(name = "id_abrigo")
    private Abrigo abrigo;

}
