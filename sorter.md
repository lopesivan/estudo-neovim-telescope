No Neovim, ao configurar o `telescope`, você pode definir um sorter personalizado para organizar os itens de forma alfabética ou de acordo com qualquer outro critério desejado. Por padrão, o `telescope` oferece algumas opções de sorter que você pode utilizar, como o `sorter.get_fuzzy_file` ou o `sorter.get_generic_fuzzy_sorter`, mas para um sorter puramente alfabético, você pode implementar uma função personalizada utilizando o módulo `sorters` do `telescope`.

### Criando um Sorter Alfabético

Você pode criar um sorter alfabético personalizado usando a API `sorters` do `telescope`. Aqui está um exemplo básico de como criar e usar um sorter alfabético:

```lua
local sorters = require('telescope.sorters')

-- Criar um sorter personalizado
local alpha_sorter = sorters.Sorter:new({
    scoring_function = function(_, prompt, line)
        -- Ignora o prompt e compara as strings diretamente
        return string.lower(line)
    end,
    compare_function = function(score_a, score_b)
        -- Compara os resultados com base na ordem alfabética das strings
        return score_a < score_b
    end
})

-- Utilizar o sorter em uma configuração de picker
require('telescope').setup({
    defaults = {
        -- Configurações padrões aqui...
    },
    pickers = {
        find_files = {
            sorter = alpha_sorter
        },
        -- Configurar outros pickers conforme necessário
    }
})
```

### Explicação do Código

1. **Scoring Function**: A função de pontuação (`scoring_function`) é usada para converter cada linha (ou item) em uma "pontuação" que pode ser comparada. Neste caso, estamos simplificando ao retornar a própria linha em minúsculas para comparação direta.

2. **Compare Function**: A função de comparação (`compare_function`) é onde você define como as "pontuações" são comparadas. No exemplo, as strings são comparadas diretamente, o que resulta numa ordenação alfabética.

### Nota

Este exemplo é bastante simplificado e não leva em conta acentuações ou outros caracteres especiais que podem afetar a ordem alfabética. Para casos mais complexos, você pode precisar de uma função de comparação mais robusta que trate corretamente a localização ou use uma biblioteca externa capaz de manipular corretamente as strings em sua língua.

Esta implementação é para ilustrar como você pode iniciar a construção de um sorter personalizado no `telescope`. Você pode ajustar as funções de pontuação e comparação conforme necessário para se adequar às suas necessidades específicas.
