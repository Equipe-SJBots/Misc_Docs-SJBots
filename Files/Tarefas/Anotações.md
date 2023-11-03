# Tarefas

## (Amalinha) Reconhecer linha preta com sensor IR #1 - ok

### Tarefa - Amalinha #1

Entender de que forma os módulos IR funcionam.
Primeiro testando com o Modulo de Sensor de obstaculo Infravermelho

| Sensor1           | Sensor2           |
| ----------------- | ----------------- |
| ![a][LinkSensor1] | ![a][LinkSensor2] |

Depois migrando para testes com os módulos maiores:

- [Módulo Seguidor de Linha 5 Canais com Fim de Curso][Link5Canais]
- [Módulo Seguidor de Linha Infravermelho - 8 Canais][Link8Canais]

[LinkSensor1]: https://www.saravati.com.br/media/catalog/product/cache/8ba61e6f43935f01927e65d3d5c2ff7a/9/d/9dcb3c4ac3.jpg
[LinkSensor2]: https://mundialcomponentes.com.br/arquivos/produtos/imagens_adicionais/575470e18c6d5161ae465caa91697ea528a3956d.jpeg
[Link5Canais]: https://produto.mercadolivre.com.br/MLB-3736002768-modulo-sensor-ir-seguidor-de-linha-tcrt5000-5-canais-_JM
[Link8Canais]: https://produto.mercadolivre.com.br/MLB-3366406243-modulo-seguidor-de-linha-infravermelho-8-canais-_JM

### Motivação - Amalinha #1

A motivação por trás da sua tarefa é para que, com o devido entendimento de como o sensor lê e responde às alterações de cores, em conjunto com a tarefa de execução dos motores, na próxima semana já consigamos fazer o robô seguir a linha.

### Resultado esperado - Amalinha #1

Espera-se que consiga usar por base o código disponível [aqui](https://github.com/Equipe-SJBots/seguidor-de-linha/blob/main/Files/arduino_testing/arduino_testing.ino) para fazer a leitura sensores e que resulte em algo como isso:

![a][LinkResultado]

[LinkResultado]: https://www.diyrobocars.com/wp-content/uploads/2020/05/Annotation-2020-04-30-213522.png

De alguma forma o sensor deve conseguir indicar quando que ele está em cima da linha preta e quando não está.

Talvez [essa leitura possa ajudar](https://www.diyrobocars.com/2020/05/04/arduino-serial-plotter-the-missing-manual/)

Lembre-se de colocar os códigos criados no [repositório do Amalinha no GitHub][LinkRepoAmalinha]

[LinkRepoAmalinha]: https://github.com/Equipe-SJBots/seguidor-de-linha/tree/main/Files

## (Amalinha) Checar o funcionamento dos motores #2 - ok

### Tarefa 2 - Amalinha #2

O Amalinha atualmente conta com 2 motores N20 controlados por uma ponte H conectada ao Arduino. Sua tarefa é entender como funciona a ponte H e como controlar os motores. Recomendo que você faça os testes programando diretamente no Arduino, sem usar o sensor IR.

Ou seja, defina funções como `moverParaFrente()`, `moverParaTras()`, `virarParaDireita()`, `virarParaEsquerda()`, `parar()`, etc. e teste cada uma delas.

O diagrama de montagem elétrica do Amalinha é algo próximo a isso:

![a][LinkDiagramaAmalinha]

[LinkDiagramaAmalinha]: https://raw.githubusercontent.com/Equipe-SJBots/misc/main/Files/Burocracia/Relatorio/JV/Imagens/Bots/Diagrama%20Amalinha.png

#### Observações

- Existe a possibilidade de que alguma solda não esteja bem feita, neste caso, conserte-a ou peça à quem tiver mais experiência.
- Atente-se de que não se deve usar necessariamente a bateria de 9V, use a bateria LiPO adequada para o projeto.

### Motivação - Amalinha #2

A motivação dessa tarefa é que em junção com [a tarefa do sensor IR](https://github.com/Equipe-SJBots/amalinha/issues/1), na semana que vem, possamos juntar os conhecimentos e códigos para fazer o Amalinha de fato seguir a linha.

### Resultado esperado 2 - Amalinha #2

Espera-se que ao fim da tarefa, haja no GitHub um código que consiga controlar os motores do Amalinha.

Espera-se que este código execute funções úteis ao movimento como:

```c
    void moverParaFrente(){
        // Deve girar ambos os motores para frente
    };
    void moverParaTras(){
        // Deve girar ambos os motores para trás
    };
    void GirarEsquerda(){
        // Deve girar apenas o motor da direita
    };
    void GirarDireita(){
        // Deve girar apenas o motor da esquerda
    };
    void GirarEsquerdaCompleto(){
        // Motor direito para frente
        // Motor esquerdo para trás
    };
    void GirarDireitaCompleto(){
        // Motor esquerdo para frente
        // Motor direito para trás
    };
```

## (Combot) Modificar a carcaça #1 - ok

### Tarefa 3 - Combot #1

Seguindo as pesagens feitas e listadas [neste link][LinkPesagem], é necessário que a carcaça do Raia seja modificada para que o peso do robô seja apropriado. Idealmente ele deve reduzir para se tornar um Fairy, mas caso isso não seja possível, ele deve se tornar um Ant.

[LinkPesagem]: https://docs.google.com/spreadsheets/d/1mhz4X6CchYzygzCDSRYp9GHxUhpNYBFs0szqu_SAMig/edit#gid=900102901

Para isso, analise de quais locais deve-se retirar material e de quais deve-se adicionar. Lembre-se de editar a planilha com as estimativas de peso de cada uma das partes, para que tenhamos noção de quais partes mais estão pesando.

As modificações devem estar de acordo com os comentários feitos por Murilo e Krishna

> reduzir o tamanho do local por onde o eixo do motor passa

E também as modificações apontadas por Jean:

> Subir um pouco a base da carcaça para que reduza o peso dos suportes dos motores e possa usar adequadamente os ziplocs

Lembre-se de entrar em contato diretamente com eles para que eles possam mensurar corretamente quais são as medidas exatas.

Outro detalhe a se adicionar são os parafusos e porcas de fixação, visto que seu peso também deve ser levado em consideração.

### Motivação - Combot #1

O propósito dessa tarefa é que o robô de combate tenha peso adequado para a categoria Fairy, e também auxiliar na comunicação interna da equipe.

### Resultado esperado 3 - Combot #1

- Deve-se ter mantido contato frequente com os que estão presentes diariamente no laboratório para que se saiba o que deve ser mudado, fazendo perguntas apropriadas para tal.
- Espera-se que todas as peças que devam ser impressas em 3D estejam disponibilizadas [nesta pasta no GitHub][LinkRepoModelo] na extensão STL
- É esperado que os novos modelo já tenha sido impresso por Jean.

[LinkRepoModelo]: https://github.com/Equipe-SJBots/first-combot/tree/main/Files/Raia/Modelos%20STL

## (Sumô LEGO) Fazer um motor girar com MicroPython #2 - Later

### Tarefa 4

Primeiro é necessário que consiga-se usar o MicroPython no EV3, para isso, siga [este tutorial][LinkTutorialMicroPython] para instalar o MicroPython no EV3, ou qualquer outro que achar mais apropriado.

[LinkTutorialMicroPython]: https://youtu.be/UgVRzm5Wjpc

### Resultado esperado 4

## (Organização) Modelar e listar os itens da arena #1 - Karine

### Tarefa - Organização #1

### Motivação - Organização #1

### Resultado esperado - Organização #1

## (Combot) Entrar em contato com fornecedores #5 - ok

### Tarefa - Combot #5

Você deve entrar em contato com fornecedores de aço e placa de carbono que entreguem até dia 10/11/23 e efetivar a compra, enviando o boleto para João ou Jean para que encaminhemos ao Allysson que realizará o pagamento.

Os itens a serem comprados são:

- Aço
  - Chapa aço 4340 com 9mm de altura (mais urgente)
  - Tarugo aço 4340 com 80mm de diâmetro
- Placa de fibra de carbono
  - 125X75X0.5mm
  - 125X75X1.0mm
  - 125X75X1.5mm

A prioridade da compra é que seja:

1. São João da Barra (pouquíssimo provável)
2. Açu (pouco provável)
3. Campos (mais provável)
4. Macaé (Karine busca)
5. RJ (Elias busca)
6. SP: R2Aços (indicado pelo Manoel, mas aparentemente não entregam)
7. Qualquer outro lugar

Uma lista de fornecedores de aço foi feita na [tabela de orçamentos](https://docs.google.com/spreadsheets/d/1wXbBAK9FQP5Bxs3OllUERSIyleKUSfgijoq2G6-hvEE/edit#gid=922059678)

### Motivação - Combot #5

A motivação dessa tarefa é para que tenhamos o material para a confecção das armas (fork e horizontal spinner) e também dos tampos dos robôs a tempo do Summit.

### Resultado Esperado - Combot #5

É esperado que ao final da semana as placas de carbono e principalmente os aços já tenham sido comprados e estejam a caminho.

## (Organização) Obter permissão dos pais para a viagem #5

### Tarefa - Organização #5

### Motivação - Organização #5

### Resultado Esperado - Organização #5

## (Organização) Fazer inscrição no Summit #6

### Tarefa - Organização #6

### Motivação - Organização #6

### Resultado Esperado - Organização #6

## (Amalinha) Cortar a base do Amalinha adequadamente #3

### Tarefa - Amalinha #3

### Motivação - Amalinha #3

### Resultado Esperado - Amalinha #3

## (Combot) Imprimir o Fairy Modificado #2

### Tarefa - Combot #2

### Motivação - Combot #2

### Resultado Esperado - Combot #2

## (Cupim) Cortar as partes da carcaça em MDF #1

### Tarefa - Cupim #1

### Motivação - Cupim #1

### Resultado Esperado - Cupim #1

## (Sumô LEGO) Montar robô LEGO 1 KG #3

### Tarefa - Sumô LEGO #3

### Motivação - Sumô LEGO #3

### Resultado Esperado - Sumô LEGO #3

## (Combots) Soldar elétrica #4 - ok

### Tarefa - Combots #4

Você deve conferir se as soldas dos robôs estão funcionando corretamente, e corrigir as soldas que não estiverem boas.

**Obs.**: lembre-se de usar o mínimo possível de fios para que não haja sobrepeso por parte da elétrica e que ele encaixe adequadamente dentro da carcaça do robô.

Os esquemas elétricos devem se basear nos que estão listados abaixo:

| [4 Brushed][Link 4 Bed] | [2 Brushed + 1 Brushless][Link 2 Brushed + 1 Brushless] | [2 Brushed][Link 2 Brushed] |
| :---------------------: | :-----------------------------------------------------: | :-------------------------: |
|  ![Imagem][4 Brushed]   |           ![Imagem][2 Brushed + 1 Brushless]            |    ![Imagem][2 Brushed]     |

[Link 4 Bed]: https://github.com/Equipe-SJBots/combots/blob/main/Files/Raia/Dino_Esquema_fork.png
[4 Brushed]: https://raw.githubusercontent.com/Equipe-SJBots/combots/main/Files/Raia/Dino_Esquema_fork.png

[Link 2 Brushed + 1 Brushless]: https://github.com/Equipe-SJBots/combots/blob/main/Files/Narcisalha/2%20Bat%202%20Esc%202%20N20%201%20BLess%201%20Rec_bb.png
[2 Brushed + 1 Brushless]: https://raw.githubusercontent.com/Equipe-SJBots/combots/main/Files/Narcisalha/2%20Bat%202%20Esc%202%20N20%201%20BLess%201%20Rec_bb.png

[Link 2 Brushed]: https://github.com/Equipe-SJBots/combots/blob/main/Files/Esquem%C3%A1ticos/Dino_Esquema.Basico.png
[2 Brushed]: https://raw.githubusercontent.com/Equipe-SJBots/combots/main/Files/Esquem%C3%A1ticos/Dino_Esquema.Basico.png

Lista de checagem:

- [ ] Amalinha
  - [ ] Módulo de Sensores IR
  - [ ] Ponte H
  - [ ] Motores
- [ ] Raia
  - [ ] 4 Motores Brushed
  - [ ] 2 ESCs
  - [ ] Receptor
- [ ] Cupim
  - [ ] 2 motores Brushed
  - [ ] 1 ESC
  - [ ] Receptor
  - [ ] Extra: Conferir com o Jean
    - Opção A
      - [ ] 1 Motor Brushless
      - [ ] 1 ESC Brushless
    - Opção B
      - [ ] 2 Motores Brushed
      - [ ] 1 ESC Brushed

### Motivação - Combots #4

O propósito de sua tarefa é que o sistema elétrico dos robôs estejam funcionando corretamente para podermos participar das competições.

### Resultado Esperado - Combots #4

É esperado que todos os robôs listados estejam com a elétrica funcional e bem soldada.

## (Organização) Por que o ferro de solda tá piorando? #8 - ok

### Tarefa - Organização #8

Você deve descobrir o motivo para o ferro de solda estar piorando.

### Motivação - Organização #8

O ferro de solda é uma ferramenta de uso recorrente para nós, e caso ela pare de funcionar ou continue piorando, pode nos causar muito transtorno e dificuldade. Sua tarefa ajudará a impedir que esse infortúnio ocorra.

### Resultado Esperado - Organização #8

É esperado que o ferro de solda esteja com problema por mau no laboratório. Se essa expectativa estiver correta, é esperado que ao fim dessa tarefa haja uma folha impressa no laboratório com regras de uso do ferro de solda, para garantir que seus futuros usos sejam apropriados.

Se não for este o caso, reportar aos bolsistas e/ou ao Allysson para que sejam tomadas as medidas providências.
