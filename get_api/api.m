let
    url = "https://dataworkspace.ufla.br/api/dados_abertos/query/",
    data = Text.ToBinary("{""conjunto_de_dados"":""estudantes_da_graduacao"",""filtros"":{""semestre_letivo_referencia"":""2023/1""}}"),
    headers = [
        #"accept" = "application/json",
        #"Content-Type" = "application/json"
    ],
    response = Json.Document(Web.Contents(url, [
        Headers=headers,
        Content=data
    ])),
    result = response,
    #"Convertido para Tabela" = Table.FromList(result, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Column1 Expandido" = Table.ExpandRecordColumn(#"Convertido para Tabela", "Column1", {"ano_letivo_referencia", "campus", "codigo_inep", "codigo_oferta_curso", "curso", "curso_modalidade", "curso_turno", "data_atualizacao_dw", "forma_ingresso", "forma_ingresso_tipo", "nome_matriz_curricular", "registro_academico", "semestre_letivo_ingresso", "semestre_letivo_referencia", "sistema_origem", "situacao_censo", "situacao_descricao", "situacao_estudante", "situacao_nome", "titulo_academico"}, {"ano_letivo_referencia", "campus", "codigo_inep", "codigo_oferta_curso", "curso", "curso_modalidade", "curso_turno", "data_atualizacao_dw", "forma_ingresso", "forma_ingresso_tipo", "nome_matriz_curricular", "registro_academico", "semestre_letivo_ingresso", "semestre_letivo_referencia", "sistema_origem", "situacao_censo", "situacao_descricao", "situacao_estudante", "situacao_nome", "titulo_academico"}),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Column1 Expandido",{{"codigo_inep", Int64.Type}, {"nome_matriz_curricular", Int64.Type}, {"registro_academico", Int64.Type}, {"data_atualizacao_dw", type datetime}, {"ano_letivo_referencia", type date}})
in
    #"Tipo Alterado"