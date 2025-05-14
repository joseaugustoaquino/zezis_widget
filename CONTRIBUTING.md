# Diretrizes de Contribuição

## Estrutura do Projeto

O projeto está organizado da seguinte forma:

```
lib/
├── src/
│   ├── components/     # Widgets e componentes reutilizáveis
│   ├── core/          # Lógica central e utilitários
│   ├── models/        # Modelos de dados
│   ├── services/      # Serviços e integrações
│   └── utils/         # Funções utilitárias
├── data/              # Dados e constantes
└── zezis_widget.dart  # Arquivo principal de exportação
```

## Padrões de Código

1. **Nomenclatura**:
   - Use nomes descritivos e em inglês
   - Classes: PascalCase
   - Métodos e variáveis: camelCase
   - Constantes: SCREAMING_SNAKE_CASE

2. **Documentação**:
   - Documente todas as classes públicas
   - Use comentários para explicar lógica complexa
   - Mantenha o README.md atualizado

3. **Testes**:
   - Escreva testes para novos componentes
   - Mantenha a cobertura de testes acima de 80%

## Processo de Contribuição

1. Crie uma branch para sua feature
2. Faça suas alterações
3. Adicione testes
4. Atualize a documentação
5. Envie um Pull Request

## Convenções de Commit

Use o formato:
```
tipo(escopo): descrição

[corpo opcional]

[rodapé opcional]
```

Tipos:
- feat: nova feature
- fix: correção de bug
- docs: documentação
- style: formatação
- refactor: refatoração
- test: testes
- chore: tarefas de manutenção 