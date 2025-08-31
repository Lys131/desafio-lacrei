# Desafio Técnico Lacrei Saúde

O objetivo desse desafio foi modelar e implementar uma estrutura de base de dados de profissionais da saúde e planos de saúde para o projeto social Lacrei Saúde.

O projeto foi desenvolvido aplicando duas abordagens diferentes: a primeira proposta, usando tabela de domínio e a segunda, usando enum.

## Proposta 1 
1) <ins>Modelagem de dados</ins>
    
    A proposta 1 envolve a modelagem de dados utilizando três entidades ou tabelas: uma tabela contendo o identificador do profissional de saúde e seus atributos; uma segunda tabela contendo o identificador do plano de saúde e seus atributos; e uma terceira fazendo a relação entre um profissional de saúde e um plano de saúde, criando um identificador do contrato entre eles e contendo outras informações necessárias nesse contexto.

2) <ins>DER</ins>
    
    ![Diagrama entidade-relacionamento desenvolvido para a proposta 1](modelagem/DER_dominio.png)
   
3) <ins>Dicionário de dados</ins>
   
    No arquivo pdf localizado no repositório *modelagem* podem ser encontradas mais informações sobre os atributos de cada tabela do DER referente a essa proposta.
   
4) <ins>Vantagens e desvantagens</ins>

    A principal vantagem dessa abordagem é a facilidade de manutenção da base de dados, cadastrando novos planos na tabela referente aos planos de saúde. Além disso, a garantia de relacionamentos consistentes entre as três tabelas devido ao uso de chaves estrangeiras (*foreign key* ou *FK*) é essencial para que não sejam adicionados profissionais ou planos de saúde duplicados, por exemplo. Ademais, a facilidade em realizar as buscas na base de dados, como quais planos um profissional de saúde aceita ou quais profissionais aceitam um plano de saúde específico.
  
    Em relação às desvantagens, é preciso destacar a necessidade de três tabelas diferentes nessa proposta, o que pode representar um peso significativo para a base de dados, aumentando os custos de armazenamento da mesma. Essa estrutura também faz com que a manutenção seja um pouco mais complexa do que apenas salvar os planos de saúde direto em um campo de uma só tabela.

5) <ins>Scripts</ins>

    Os scripts para criação das tabelas e índices podem ser encontrados no repositório *scripts*.

## Proposta 2

1) <ins>Modelagem de dados</ins>
    
    A proposta 2 envolve a modelagem de dados utilizando uma tabela referente aos profissionais de saúde, contendo o identificador do profissional e seus atributos, dos quais um deles é um campo designado aos planos de saúde que esse profissional aceita. Esse campo é do tipo enum e contém dados em texto (*string*) com os planos aceitos pelo profissional; no entanto, esses dados são decodificados como números.

2) <ins>DER</ins>
    
    ![Diagrama entidade-relacionamento desenvolvido para a proposta 2](modelagem/DER_enum.png)
   
3) <ins>Dicionário de dados</ins>
   
    No arquivo pdf localizado no repositório *modelagem* podem ser encontradas mais informações sobre os atributos de cada tabela do DER referente a essa proposta.
   
4) <ins>Vantagens e desvantagens</ins>

    A principal vantagem da proposta 2 é a simplicidade da estrutura da base de dados contendo apenas uma tabela, além de a estrutura ENUM necessitar de 1/6 do espaço de armazenamento de um dado de tipo *string*. A inserção de novos profissionais de saúde na base também é facilitada, pois não é necessário atualizar a tabela de profissionais de saúde e a tabela de domínio.

   Quanto às desvantagens deve-se destacar a limitação de escalabilidade e a maior complexidade para utilizar filtros como profissionais para um plano de saúde específico quando utilizada a estrutura ENUM. Dificuldades também podem surgir ao utilizar números, quando é necessário ordenar os valores contidos no ENUM e quando é necessário inserir um novo plano de saúde na tabela.
   
5) <ins>Scripts</ins>

    Os scripts para criação das tabelas e índices podem ser encontrados no repositório *scripts*.

## Reflexão sobre uso de `jsonb`

**jsonb** é um tipo de dado desenvolvido para armazenar dados do tipo JSON em um formato binário otimizado e decomposto. Dados do tipo JSON se assemelham a um dicionário da linguagem de código Python, permitindo o armazenamento de dados complexos, mas ainda assim estruturados e unidos. Dessa forma, o uso desse tipo de estrutura no contexto do desafio seria adequado na **proposta 1**. 
    
Na tabela de domínio, na qual se faz a relação entre os profissionais de saúde e os planos, existe o campo *condicoes_atendimento*, onde poderiam ficar armazenadas múltiplas informações, como limite de consultas, horário de atendimeno e observações. No repositório *scripts*, podem ser encontrados o script para a criação do atributo `jsonb` e a inserção de dados.
