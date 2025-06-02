package br.com.AlertHaven.AlertHaven.http;

import br.com.AlertHaven.AlertHaven.dto.response.EnderecoViaCep;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "viacep-client", url = "https://viacep.com.br/ws")
public interface ViaCepClient {
    @GetMapping("/{cep}/json")
    EnderecoViaCep obterEnderecoAbrigo(@PathVariable String id);
}
