package br.com.AlertHaven.AlertHaven.service;

import br.com.AlertHaven.AlertHaven.dto.request.AtualizarAbrigoRequestDTO;
import br.com.AlertHaven.AlertHaven.entity.Abrigo;
import br.com.AlertHaven.AlertHaven.entity.TipoEmergencia;
import br.com.AlertHaven.AlertHaven.exception.AbrigoNaoEncontradoException;
import br.com.AlertHaven.AlertHaven.repository.AbrigoRepository;
import br.com.AlertHaven.AlertHaven.repository.TipoEmergenciaRepository;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class AbrigoService {

    private AbrigoRepository abrigoRepository;
    private TipoEmergenciaRepository tipoEmergenciaRepository;

    public Abrigo cadastrarAbrigo(Abrigo abrigo, List<Integer> idsTipoEmergencia) {
        idsTipoEmergencia.forEach(i -> {
            TipoEmergencia tipoEmergencia = tipoEmergenciaRepository.findById(i)
                    .orElseThrow(() -> new AbrigoNaoEncontradoException("Tipo de Emergência não encontrado"));
            abrigo.getTipoEmergencias().add(tipoEmergencia);
        });
        return abrigoRepository.save(abrigo);
    }

    public List<Abrigo> listarAbrigos() {
        return abrigoRepository.findAll();
    }

    public Abrigo obterAbrigoPorId(String id) {
        return abrigoRepository.findById(id).orElseThrow(() -> new AbrigoNaoEncontradoException("Abrigo não encontrado"));
    }

    public void deletarAbrigoPorId(String id) {
        abrigoRepository.deleteById(id);
    }

    @Transactional
    public Abrigo atualizarAbrigo(String id, @Valid AtualizarAbrigoRequestDTO dto) {
        Abrigo abrigo = obterAbrigoPorId(id);

        abrigo.setNomeAbrigo(dto.getNomeAbrigo());
        abrigo.setEmailAbrigo(dto.getEmailAbrigo());
        abrigo.setCapacidadeSuportadaAbrigo(dto.getCapacidadeSuportadaAbrigo());

        return abrigo;
    }

}
