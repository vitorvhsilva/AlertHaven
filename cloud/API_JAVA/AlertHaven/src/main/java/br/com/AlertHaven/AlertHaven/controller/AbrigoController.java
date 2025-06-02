package br.com.AlertHaven.AlertHaven.controller;

import br.com.AlertHaven.AlertHaven.dto.request.AtualizarAbrigoRequestDTO;
import br.com.AlertHaven.AlertHaven.dto.request.CadastrarAbrigoRequestDTO;
import br.com.AlertHaven.AlertHaven.dto.response.LocalizacaoDTO;
import br.com.AlertHaven.AlertHaven.dto.response.ObterAbrigoCompletoResponseDTO;
import br.com.AlertHaven.AlertHaven.dto.response.ObterAbrigoSimplesResponseDTO;
import br.com.AlertHaven.AlertHaven.entity.Abrigo;
import br.com.AlertHaven.AlertHaven.entity.Localizacao;
import br.com.AlertHaven.AlertHaven.entity.TipoEmergencia;
import br.com.AlertHaven.AlertHaven.service.AbrigoService;
import br.com.AlertHaven.AlertHaven.service.LocalizacaoService;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@AllArgsConstructor
@RestController
@RequestMapping("/abrigos")
public class AbrigoController {

    private AbrigoService abrigoService;
    private ModelMapper mapper;
    private LocalizacaoService localizacaoService;

    @PostMapping
    public ResponseEntity<ObterAbrigoCompletoResponseDTO> cadastrarAbrigo(@RequestBody CadastrarAbrigoRequestDTO dto) {
        Abrigo abrigo = mapper.map(dto, Abrigo.class);
        Abrigo abrigoCadastrado = abrigoService.cadastrarAbrigo(abrigo, dto.getIdsTipoEmergencia());
        Localizacao localizacao = localizacaoService.persistirLocalizacao(dto.getCep(), abrigoCadastrado);
        abrigoCadastrado.setLocalizacao(localizacao);


        return ResponseEntity.status(HttpStatus.CREATED).body(converterEntidadeParaDTOCompleto(abrigoCadastrado));
    }

    @GetMapping
    public List<ObterAbrigoSimplesResponseDTO> listarAbrigos(){
        List<Abrigo> abrigos = abrigoService.listarAbrigos();
        return abrigos.stream()
                .map(abrigo -> mapper.map(abrigo, ObterAbrigoSimplesResponseDTO.class))
                .toList();
    }

    @GetMapping("/{id}")
    public ResponseEntity<ObterAbrigoCompletoResponseDTO> obterAbrigoPorId(@PathVariable String id) {
        Abrigo abrigo = abrigoService.obterAbrigoPorId(id);

        return ResponseEntity.ok(converterEntidadeParaDTOCompleto(abrigo));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ObterAbrigoCompletoResponseDTO> atualizarAbrigo(@PathVariable String id, @Valid @RequestBody AtualizarAbrigoRequestDTO dto) {
        Abrigo abrigo = abrigoService.atualizarAbrigo(id, dto);

        return ResponseEntity.ok(converterEntidadeParaDTOCompleto(abrigo));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletarAbrigo(@PathVariable String id){
        abrigoService.deletarAbrigoPorId(id);

        return ResponseEntity.notFound().build();
    }

    private ObterAbrigoCompletoResponseDTO converterEntidadeParaDTOCompleto(Abrigo abrigo) {
        ObterAbrigoCompletoResponseDTO response = mapper.map(abrigo, ObterAbrigoCompletoResponseDTO.class);
        response.setLocalizacao(mapper.map(abrigo.getLocalizacao(), LocalizacaoDTO.class));
        response.setTiposEmergencias(abrigo.getTipoEmergencias().stream()
                .map(TipoEmergencia::getTipoEmergencia)
                .toList());

        return response;
    }
}
