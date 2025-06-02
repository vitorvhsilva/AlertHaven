package br.com.AlertHaven.AlertHaven.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Table(name = "TB_TIPO_EMERGENCIA")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TipoEmergencia {

    @Id
    @Column(name = "id_tipo_emergencia")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idTipoEmergencia;

    @Column(name = "tipo_emergencia")
    private String tipoEmergencia;


    @ManyToMany(mappedBy = "tipoEmergencias", cascade = CascadeType.ALL)
    private List<Abrigo> abrigos;
}
