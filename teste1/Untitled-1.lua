EPAT_CONFIG_AUTOS = {}
EPAT_CONFIG_AUTOS_INFRACOES = {}
TIPOS_INFRACOES = {}
INFRACOES = {}
INFRACOES_LANCAMENTOS = {}
LANCAMENTOS_ITBI = {}
--epat functions
epat = {}
---------------------------------------------------------------------
EPAT_CONFIG_AUTOS.Save = function(obj)
  local retorno = 0
  if coalesce(obj.idEpatConfigAuto, 0) == 0 then
    obj.idEpatConfigAuto = EPAT_CONFIG_AUTOS.Insert(obj)
    retorno = obj.idEpatConfigAuto
    --if((obj.TipoItem in [1, 4]) and (obj.idEpatConfigAuto > 0))then --verificar como usar desta forma com o in []
    if(((obj.TipoItem == 1) or (obj.TipoItem == 4)) and (obj.idEpatConfigAuto > 0))then
      return EPAT_CONFIG_AUTOS_INFRACOES.Save(obj, 'novo')
    end
  else
    retorno = EPAT_CONFIG_AUTOS.Update(obj)
    --if((obj.TipoItem in [1, 4]) and (obj.idEpatConfigAuto > 0))then
    if(((obj.TipoItem == 1) or (obj.TipoItem == 4)) and (obj.idEpatConfigAuto > 0))then
      return EPAT_CONFIG_AUTOS_INFRACOES.Save(obj, 'update')
    end
  end
    return retorno  
end
--------------------------------------------------------------------------------
EPAT_CONFIG_AUTOS.Insert = function(obj)
  local qr = SQLSelect('SELECT SEQ_EPAT_CONFIG_AUTOS_LEANDRO.NEXTVAL AS ID FROM PAR_INSTITUICAO')
  SQLExecute([[
    INSERT INTO EPAT_CONFIG_AUTOS_LEANDRO(
    ID_EPAT_CONFIG_AUTO, 
    ID_TIPO_DOC, 
    TIPO_ITEM, 
    TEXTO_LEGAL, 
    AUDITOR_FISCAL_ITEM, 
    JUIZ_1INSTANCIA_ITEM, 
    JUIZ_2INSTANCIA_ITEM, 
    IND_EDIT_DT_AUTUACAO, 
    COD_OPERADOR, 
    DT_ALTERACAO, 
    HR_ALTERACAO, 
    CONCORRENCIA, 
    ENDERECO_FISICO) 
    VALUES (
    :ID_EPAT_CONFIG_AUTO, 
    :ID_TIPO_DOC, 
    :TIPO_ITEM, 
    :TEXTO_LEGAL, 
    :AUDITOR_FISCAL_ITEM, 
    :JUIZ_1INSTANCIA_ITEM, 
    :JUIZ_2INSTANCIA_ITEM, 
    :IND_EDIT_DT_AUTUACAO, 
    0, 
    CURRENT DATE, 
    CURRENT TIME, 
    0, 
    '')
  ]],{
    {'ID_EPAT_CONFIG_AUTO', 'ftInteger', qr[1].ID},
    {'ID_TIPO_DOC', 'ftInteger', obj.IdTipoDoc, 0},
    {'TIPO_ITEM','ftInteger', obj.TipoItem, 0},
    {'TEXTO_LEGAL', 'ftMemo', obj.TextoLegal, nil, 5000000},
    {'AUDITOR_FISCAL_ITEM', 'ftInteger', obj.AuditorFiscalItem, 0},
    {'JUIZ_1INSTANCIA_ITEM', 'ftInteger', obj.Juiz1InstanciaItem, 0},
    {'JUIZ_2INSTANCIA_ITEM', 'ftInteger', obj.Juiz2InstanciaItem, 0},
    {'IND_EDIT_DT_AUTUACAO', 'ftString', obj.IndEditDtAutuacao, nil, 1}
  }) 
  return qr[1].ID
end
---------------------------------------------------------------------
EPAT_CONFIG_AUTOS.Update = function(obj)
  local q = [[
    UPDATE EPAT_CONFIG_AUTOS_LEANDRO SET               
      ID_TIPO_DOC = :ID_TIPO_DOC]] ..
      iff(obj.TipoItem, ',TIPO_ITEM = :TIPO_ITEM','') ..
      iff(obj.TextoLegal, ',TEXTO_LEGAL = :TEXTO_LEGAL','') ..
      iff(obj.AuditorFiscalItem, ',AUDITOR_FISCAL_ITEM = :AUDITOR_FISCAL_ITEM','') ..
      iff(obj.Juiz1InstanciaItem, ',JUIZ_1INSTANCIA_ITEM = :JUIZ_1INSTANCIA_ITEM','') ..
      iff(obj.Juiz2InstanciaItem, ',JUIZ_2INSTANCIA_ITEM = :JUIZ_2INSTANCIA_ITEM','') ..
      iff(obj.IndEditDtAutuacao, ',IND_EDIT_DT_AUTUACAO = :IND_EDIT_DT_AUTUACAO','')..[[
    WHERE ID_EPAT_CONFIG_AUTO = :ID_EPAT_CONFIG_AUTO
  ]]
  local p = {
    {'ID_EPAT_CONFIG_AUTO', 'ftInteger', obj.idEpatConfigAuto},
    {'ID_TIPO_DOC', 'ftInteger', obj.IdTipoDoc},
    iff(obj.TipoItem, {'TIPO_ITEM','ftInteger', obj.TipoItem}, nil),
    iff(obj.TextoLegal, {'TEXTO_LEGAL','ftMemo', obj.TextoLegal, '', 5000000}, nil),
    iff(obj.AuditorFiscalItem, {'AUDITOR_FISCAL_ITEM','ftInteger', obj.AuditorFiscalItem}, nil),
    iff(obj.Juiz1InstanciaItem, {'JUIZ_1INSTANCIA_ITEM','ftInteger', obj.Juiz1InstanciaItem}, nil),
    iff(obj.Juiz2InstanciaItem, {'JUIZ_2INSTANCIA_ITEM','ftInteger', obj.Juiz2InstanciaItem}, nil),
    iff(obj.IndEditDtAutuacao, {'IND_EDIT_DT_AUTUACAO','ftString', obj.IndEditDtAutuacao}, nil)
  }
  SQLExecute(q,p)
  return obj.idEpatConfigAuto
end
---------------------------------------------------------------------
EPAT_CONFIG_AUTOS_INFRACOES.Save = function(obj, action)
  if action == 'novo' then
    return EPAT_CONFIG_AUTOS_INFRACOES.Insert(obj)  
  else
    return EPAT_CONFIG_AUTOS_INFRACOES.Update(obj)
  end
end
--------------------------------------------------------------------------------
EPAT_CONFIG_AUTOS_INFRACOES.Insert = function(obj)
  local qr
  for i=1, sizeOf(obj.TiposInfra) do
    if(obj.TiposInfra[i].ID_TIPO_INFRACAO >= 0)then
      qr = SQLSelect('SELECT SEQ_EPAT_CONFIG_AUTOS_INFRACOES_LEANDRO.NEXTVAL AS ID FROM PAR_INSTITUICAO')
      SQLExecute([[
        INSERT INTO EPAT_CONFIG_AUTOS_INFRACOES_LEANDRO(
        ID_EPAT_CONFIG_AI, ID_EPAT_CONFIG_AUTO, ID_TIPO_INFRACAO, COD_OPERADOR, DT_ALTERACAO, HR_ALTERACAO, CONCORRENCIA, ENDERECO_FISICO) 
        VALUES (
        :ID_EPAT_CONFIG_AI, :ID_EPAT_CONFIG_AUTO, :TIPO_ITEM, 0, CURRENT DATE, CURRENT TIME, 0, '')
      ]],{
        {'ID_EPAT_CONFIG_AI', 'ftInteger', qr[1].ID},
        {'ID_EPAT_CONFIG_AUTO', 'ftInteger', obj.idEpatConfigAuto},
        {'TIPO_ITEM', 'ftInteger', obj.TiposInfra[i].ID_TIPO_INFRACAO}
      }) 
    end 
  end
  return obj.idEpatConfigAuto
end
--------------------------------------------------------------------------------
EPAT_CONFIG_AUTOS_INFRACOES.Update = function(obj)
  local infraBanco --array com as infrações vindas do banco
  if sizeOf(obj.TiposInfra) then --array com as infrações vindas da tela pelo objeto
    infraBanco = GetTiposInfra(obj.idEpatConfigAuto)  
    if sizeOf(infraBanco) and not(infrabanco == 0) then --verifica se encontrou elementos no banco
      for i=1, sizeOf(obj.TiposInfra) do   
        for j=1, sizeOf(infraBanco) do
          if obj.TiposInfra[i].ID_TIPO_INFRACAO == infraBanco[j].ID_TIPO_INFRACAO then
            obj.TiposInfra[i].ID_TIPO_INFRACAO = -1 --'remove' elemento do array'
            infraBanco[j].ID_TIPO_INFRACAO = -1 --'remove' elemento do array'
            break
          end         
        end
      end 
      local retorno EPAT_CONFIG_AUTOS_INFRACOES.Insert(obj)  --faz insert dos elementos que 'sobraram' 
      for i=1, sizeOf(infraBanco) do
        if infraBanco[i].ID_TIPO_INFRACAO >= 0 then
          DeleteInfra(obj.idEpatConfigAuto, infraBanco[i].ID_TIPO_INFRACAO) --exclui do banco elementos que sobraram na lista 
        end     
      end  
    else
      local retorno EPAT_CONFIG_AUTOS_INFRACOES.Insert(obj) --se nãohá elementos relacionados com o auto, deve inserir diretamente no banco
    end 
  end
end
---------------------------------------------------------------------
TIPOS_INFRACOES.Save = function(obj)
  if(coalesce(obj.idTipoInfra, 0) == 0) then
    return TIPOS_INFRACOES.Insert(obj)
  else
    return TIPOS_INFRACOES.Update(obj)
  end
end
----------------------------------------------------------------------
TIPOS_INFRACOES.Insert = function(obj)
  local qr = SQLSelect('SELECT SEQ_TIPOS_INFRACOES.NEXTVAL AS ID FROM PAR_INSTITUICAO')
  SQLExecute([[
    INSERT INTO TIPOS_INFRACOES(
      ID_TIPO_INFRACAO, DESCR_INFRACAO, VL_MULTA, 
      IND_TIPO_INFRACAO, COD_OPERADOR, DT_ALTERACAO, 
      HR_ALTERACAO, CONCORRENCIA, MOEDA_TAB, MOEDA_ITEM, 
      CAPITULACAO_LEGAL, ENDERECO_FISICO) 
    VALUES (
    :ID_TIPO_INFRA, 
    :DESCR_INFRACAO, 
    :VL_MULTA, 
    :IND_TIPO_INFRACAO, 
    0,
    CURRENT DATE,
    CURRENT TIME,
    0,
    129, 
    :MOEDA_ITEM, 
    :CAPITULACAO_LEGAL, 
    '')
  ]],{
    {'ID_TIPO_INFRA', 'ftInteger', qr[1].ID},
    {'DESCR_INFRACAO', 'ftString', obj.Descricao, nil, 2048},
    {'VL_MULTA','ftFloat', obj.VlInfra},
    {'IND_TIPO_INFRACAO', 'ftString', obj.Tipo, nil, 1},
    {'MOEDA_ITEM', 'ftInteger', obj.Moeda, 0},
    {'CAPITULACAO_LEGAL', 'ftMemo', obj.CapitulacaoLegal, nil, 5000000}
  }) 
  return qr[1].ID  
end
----------------------------------------------------------------------
TIPOS_INFRACOES.Update = function(obj)
  local q = [[
    UPDATE TIPOS_INFRACOES SET               
      ID_TIPO_INFRACAO = :ID_TIPO_INFRACAO]] ..
      iff(obj.Descricao, ',DESCR_INFRACAO = :DESCR_INFRACAO','') ..
      iff(obj.VlInfra, ',VL_MULTA = :VL_MULTA', '') ..
      iff(obj.Tipo, ',IND_TIPO_INFRACAO = :IND_TIPO_INFRACAO','') ..
      iff(obj.Moeda, ',MOEDA_ITEM = :MOEDA_ITEM','') ..
      iff(obj.CapitulacaoLegal, ',CAPITULACAO_LEGAL = :CAPITULACAO_LEGAL','')..[[
    WHERE ID_TIPO_INFRACAO = :ID_TIPO_INFRACAO
  ]]
  local p = {
    {'ID_TIPO_INFRACAO', 'ftInteger', obj.idTipoInfra},
    iff(obj.Descricao, {'DESCR_INFRACAO','ftString', obj.Descricao, '', 2048}, nil),
    iff(obj.VlInfra, {'VL_MULTA','ftFloat', obj.VlInfra}, nil),
    iff(obj.Tipo, {'IND_TIPO_INFRACAO','ftString', obj.Tipo, '', 1}, nil),
    iff(obj.Moeda, {'MOEDA_ITEM','ftInteger', obj.Moeda}, nil),
    iff(obj.CapitulacaoLegal, {'CAPITULACAO_LEGAL','ftString', obj.CapitulacaoLegal, '', 5000000}, nil)
  }
  SQLExecute(q,p)
  return obj.idTipoInfra
end
----------------------------------------------------------------------
GetTiposInfra = function(idAuto)
  local qr = SQLSelect([[
    SELECT ID_TIPO_INFRACAO 
    FROM EPAT_CONFIG_AUTOS_INFRACOES_LEANDRO
    WHERE ID_EPAT_CONFIG_AUTO = :ID_AUTO
  ]], {
    {'ID_AUTO', 'ftInteger', idAuto}
  })
  if qr then
    return qr
  else
    return 0  --raise('Nenhum item encontrado.')
  end
end
----------------------------------------------------------------------
DeleteInfra = function(idAuto, idInfra)
  local sqlInfra = [[DELETE EPAT_CONFIG_AUTOS_INFRACOES_LEANDRO  WHERE ID_EPAT_CONFIG_AUTO = :ID_AUTO AND ID_TIPO_INFRACAO = :ID_INFRA]]
  local params = {{'ID_AUTO', 'ftInteger', idAuto, 0}, {'ID_INFRA', 'ftInteger', idInfra, 0}}
  SQLExecute(sqlInfra, params)
end
----------------------------------------------------------------------
INFRACOES.Save = function(obj)
  if coalesce(obj.idItensDocInf, 0) == 0 then
    return INFRACOES.Insert(obj)
  else
    return INFRACOES.Update(obj)
  end
end
--------------------------------------------------------------------------------
INFRACOES.Insert = function(json)
  local qr = SQLSelect('SELECT SEQ_ITENS_AUTOINFRACAO.NEXTVAL AS ID FROM PAR_INSTITUICAO')  
  
  SQLExecute([[
    INSERT INTO ITENS_AUTOINFRACAO(
    ID_ITENS_DOC_INF, 
    ID_AUTO_INFRACAO, 
    ID_TIPO_INFRACAO, 
    VL_MULTA, 
    COD_OPERADOR, 
    DT_ALTERACAO, 
    HR_ALTERACAO, 
    CONCORRENCIA, 
    MOEDA_NAC_TAB, 
    MOEDA_NAC_ITEM, 
    VL_MULTA_LANC, 
    MOEDA_LANC_TAB, 
    MOEDA_LANC_ITEM, 
    NUM_OCORRENCIAS, 
    MOEDA_TAB, 
    MOEDA_ITEM, 
    VL_BASE_FATO, 
    COD_ITEM) 
  	VALUES(
    :ID_ITENS_DOC_INF, 
    :ID_AUTO_INFRACAO, 
    :ID_TIPO_INFRACAO, 
    CASE WHEN :MOEDA_ITEM = 1 THEN :VL_BASE_FATO ELSE FPLAN_PRINCIPAL(:VL_BASE_FATO, :MOEDA_ITEM, CURRENT DATE, MONTH(CURRENT DATE), YEAR(CURRENT DATE), CURRENT DATE, (SELECT ID_TRIBUTO_IMP FROM TRIBUTOS_IMP WHERE COD_TRIBUTO = 'INFRACAO'), 0) END,
    :CTX_ID_USUARIO, 
    CURRENT DATE, 
    CURRENT TIME, 
    0, 
    129, 
    1, 
    CASE WHEN :MOEDA_ITEM = 1 THEN :VL_BASE_FATO ELSE FPLAN_PRINCIPAL(:VL_BASE_FATO, :MOEDA_ITEM, CURRENT DATE, MONTH(CURRENT DATE), YEAR(CURRENT DATE), CURRENT DATE, (SELECT ID_TRIBUTO_IMP FROM TRIBUTOS_IMP WHERE COD_TRIBUTO = 'INFRACAO'), 0) END,
    129, 
    1, 
    :NUM_OCORRENCIAS, 
    129, 
    :MOEDA_ITEM, 
    :VL_BASE_FATO, 
    :COD_ITEM)]], {
    {'ID_ITENS_DOC_INF', 'ftInteger', qr[1].ID, 0},                    
    {'ID_AUTO_INFRACAO', 'ftInteger', json.idAutoInfracao, 0}, 
    {'ID_TIPO_INFRACAO', 'ftInteger', json.idTipoInfracao, 0},
    {'VL_BASE_FATO', 'ftFloat', json.vlBaseFato, 0},  
    {'MOEDA_ITEM', 'ftInteger', json.moedaItem, 0},
    {'NUM_OCORRENCIAS', 'ftInteger', json.numOcorrencias},
    {'COD_ITEM', 'ftString', json.codItem}
  })
end
--------------------------------------------------------------------------------
INFRACOES.Update = function(json)
  local q = [[
    UPDATE ITENS_AUTOINFRACAO SET               
      ID_ITENS_DOC_INF = :ID_ITENS_DOC_INF]] ..
      iff(json.idTipoInfracao, ',ID_TIPO_INFRACAO = :ID_TIPO_INFRACAO','') ..
      iff(json.idTipoInfracao, ',VL_MULTA = CASE WHEN :MOEDA_ITEM = 1 THEN :VL_BASE_FATO ELSE FPLAN_PRINCIPAL(:VL_BASE_FATO, :MOEDA_ITEM, CURRENT DATE, MONTH(CURRENT DATE), YEAR(CURRENT DATE), CURRENT DATE, (SELECT ID_TRIBUTO_IMP FROM TRIBUTOS_IMP WHERE COD_TRIBUTO = :INFRACAO), 0) END','') ..
      iff(json.idTipoInfracao, ',VL_MULTA_LANC = CASE WHEN :MOEDA_ITEM = 1 THEN :VL_BASE_FATO ELSE FPLAN_PRINCIPAL(:VL_BASE_FATO, :MOEDA_ITEM, CURRENT DATE, MONTH(CURRENT DATE), YEAR(CURRENT DATE), CURRENT DATE, (SELECT ID_TRIBUTO_IMP FROM TRIBUTOS_IMP WHERE COD_TRIBUTO = :INFRACAO), 0) END','') ..
      iff(json.numOcorrencias, ',NUM_OCORRENCIAS = :NUM_OCORRENCIAS','') ..
      iff(json.moedaItem, ',MOEDA_ITEM = :MOEDA_ITEM','') ..
      iff(json.codItem, ',COD_ITEM = :COD_ITEM','') ..
      iff(json.vlBaseFato, ',VL_BASE_FATO = :VL_BASE_FATO','')..[[
    WHERE ID_ITENS_DOC_INF = :ID_ITENS_DOC_INF
  ]]
  local p = {
    {'ID_ITENS_DOC_INF', 'ftInteger', json.idItensDocInf},
    iff(json.idTipoInfracao, {'ID_TIPO_INFRACAO','ftInteger', json.idTipoInfracao}, nil),
    iff(json.TextoLegal, {'VL_MULTA','ftMemo', json.TextoLegal, '', 5000000}, nil),
    iff(json.numOcorrencias, {'NUM_OCORRENCIAS','ftInteger', json.numOcorrencias}, nil),
    iff(json.codItem, {'COD_ITEM','ftString', json.codItem}, nil),
    iff(json.idTipoInfracao, {'INFRACAO','ftString', 'INFRACAO'}, nil),
    iff(json.moedaItem, {'MOEDA_ITEM','ftInteger', json.moedaItem}, nil),
    iff(json.vlBaseFato, {'VL_BASE_FATO','ftFloat', json.vlBaseFato}, nil)
  }
  SQLExecute(q,p)   
end
--------------------------------------------------------------------------------
INFRACOES_LANCAMENTOS.Save = function(obj)
  if coalesce(obj.idCalcInfracao, 0) == 0 then
    return INFRACOES_LANCAMENTOS.Insert(obj)
  else
    return INFRACOES_LANCAMENTOS.Update(obj)
  end
end
--------------------------------------------------------------------------------
INFRACOES_LANCAMENTOS.Insert = function(json)
  local qr = SQLSelect('SELECT SEQ_CALCULO_INFRACAO.NEXTVAL AS ID FROM PAR_INSTITUICAO')
  SQLExecute([[
    INSERT INTO CALCULO_INFRACAO(
    ID_CALC_INFRACAO, ID_AUTO_INFRACAO, ANO_EXERCICIO, MES_EXERCICIO_TAB, MES_EXERCICIO_ITEM, VL_REC_BRUTA, VL_RECEITA_TRIB, ALIQUOTA, VL_DEVIDO, 
    VL_PAGO, 
    VL_CORRECAO,
    COD_OPERADOR, 
    DT_ALTERACAO, HR_ALTERACAO, CONCORRENCIA, MOEDA_NAC_TAB, MOEDA_NAC_ITEM,
    VL_MULTA_PUN, 
    MOEDA_LANC_TAB, MOEDA_LANC_ITEM, VL_REC_BRUTA_LANC, VL_REC_TRIB_LANC, VL_DEVIDO_LANC, VL_PAGO_LANC, 
    VL_CORRECAO_LANC, 
    VL_MULTA_PUN_LANC, 
    TX_MULTA_PUN_TAB, TX_MULTA_PUN_ITEM, COD_ITEM, ID_LISTA_SERVICO, VL_PRINC_PG, VL_PRINC_PG_LANC) 
  VALUES( 
    :ID_CALC_INFRACAO, :ID_AUTO_INFRACAO, :ANO_EXERCICIO, 142, :MES_EXERCICIO_ITEM, :VL_REC_BRUTA, :VL_RECEITA_TRIB, :ALIQUOTA, ROUND(:VL_RECEITA_TRIB * :ALIQUOTA / 100 , 2), 
    :VL_PAGO, 
    FPLAN_CORRECAO(ROUND(:VL_RECEITA_TRIB * :ALIQUOTA / 100 , 2),1,ADD_MONTHS(TO_DATE(:DATA,'DD/MM/YYYY'),1) ,:MES_EXERCICIO_ITEM,:ANO_EXERCICIO,(SELECT ID_TRIBUTO_IMP FROM TRIBUTOS_IMP WHERE COD_TRIBUTO = 'INFRACAO'),0,0,CURRENT DATE),
    :CTX_ID_USUARIO,
    CURRENT DATE, CURRENT TIME, 0, 129, 1,
    ]].. iff(json.sigla == 0, '0', 'ROUND((ROUND(:VL_RECEITA_TRIB * :ALIQUOTA / 100 , 2) - :VL_PAGO) * :SIGLA / 100, 2)')..[[,
    129, 1, :VL_REC_BRUTA, :VL_RECEITA_TRIB, ROUND(:VL_RECEITA_TRIB * :ALIQUOTA / 100 , 2), :VL_PAGO, 
    FPLAN_CORRECAO(ROUND(:VL_RECEITA_TRIB * :ALIQUOTA / 100 , 2),1,ADD_MONTHS(TO_DATE(:DATA,'DD/MM/YYYY'),1) ,:MES_EXERCICIO_ITEM,:ANO_EXERCICIO,(SELECT ID_TRIBUTO_IMP FROM TRIBUTOS_IMP WHERE COD_TRIBUTO = 'INFRACAO'),0,0,CURRENT DATE),
    ROUND((ROUND(:VL_RECEITA_TRIB * :ALIQUOTA / 100 , 2) - :VL_PAGO) * :SIGLA / 100, 2),
    290, :TX_MULTA_PUN_ITEM, :COD_ITEM, :ID_LISTA_SERVICO, :VL_PAGO, :VL_PAGO)]], {
    --params
    {'ID_CALC_INFRACAO', 'ftInteger', qr[1].ID, 0},                    
    {'ID_AUTO_INFRACAO', 'ftInteger', json.idAutoInfracao, 0}, 
    {'ANO_EXERCICIO', 'ftInteger', json.exercicio, 0},
    {'MES_EXERCICIO_ITEM', 'ftInteger', json.competencia, 0},
    {'VL_REC_BRUTA', 'ftFloat', json.receitaBruta, 0},
    {'VL_RECEITA_TRIB', 'ftFloat', json.receitaTributaria, 0},          
    {'ALIQUOTA', 'ftFloat', json.aliquota, 0}, 
    iff(json.vlPago, {'VL_PAGO', 'ftFloat', json.vlPago}, {'VL_PAGO', 'ftFloat', 0}),
    {'TX_MULTA_PUN_ITEM', 'ftInteger', json.txMultaPunItem, 0},
    {'ID_LISTA_SERVICO', 'ftInteger', json.idListaServico, 0},
    iff(json.sigla, {'SIGLA', 'ftInteger', json.sigla, 0}, {'SIGLA', 'ftInteger', 0, 0}),
    {'COD_ITEM', 'ftString', json.item, nil, 10},
    {'DATA', 'ftString', json.data, nil, 500}
  })
  return qr[1].ID
end
--------------------------------------------------------------------------------
INFRACOES_LANCAMENTOS.Update = function(json)
  local q = [[
    UPDATE CALCULO_INFRACAO SET               
      ID_CALC_INFRACAO = :ID_CALC_INFRACAO]] ..
      iff(json.exercicio, ',ANO_EXERCICIO = :ANO_EXERCICIO','') ..
      iff(json.receitaBruta, ',VL_REC_BRUTA = :VL_REC_BRUTA','') ..
      iff(json.receitaTributaria, ',VL_RECEITA_TRIB = :VL_RECEITA_TRIB','') ..      
      iff(json.aliquota, ',ALIQUOTA = :ALIQUOTA','') ..
      iff((json.aliquota) and (json.receitaTributaria), ',VL_DEVIDO = ROUND(:VL_RECEITA_TRIB * :ALIQUOTA / 100 , 2)','') ..
      iff(json.vlPago, ',VL_PAGO = :VL_PAGO',',VL_PAGO = :VL_PAGO') ..
      iff(json.data, ',VL_CORRECAO = FPLAN_CORRECAO(ROUND(:VL_RECEITA_TRIB * :ALIQUOTA / 100 , 2),1,ADD_MONTHS(TO_DATE(:DATA, :FORMAT_DATA),1) ,:MES_EXERCICIO_ITEM,:ANO_EXERCICIO,(SELECT ID_TRIBUTO_IMP FROM TRIBUTOS_IMP WHERE COD_TRIBUTO = :INFRACAO),0,0,CURRENT DATE)','') ..     
      iff(json.sigla == 0, ',VL_MULTA_PUN = 0', ',VL_MULTA_PUN = ROUND((ROUND(:VL_RECEITA_TRIB * :ALIQUOTA / 100 , 2) - :VL_PAGO) * :SIGLA / 100, 2)') ..
      iff(json.receitaBruta, ',VL_REC_BRUTA_LANC = :VL_REC_BRUTA','') ..
      iff(json.receitaTributaria, ',VL_REC_TRIB_LANC = :VL_RECEITA_TRIB','') ..     
      iff((json.aliquota) and (json.receitaTributaria), ',VL_DEVIDO_LANC = ROUND(:VL_RECEITA_TRIB * :ALIQUOTA / 100 , 2)','') ..
      iff(json.vlPago, ',VL_PAGO_LANC = :VL_PAGO','') ..
      iff(json.data, ',VL_CORRECAO_LANC = FPLAN_CORRECAO(ROUND(:VL_RECEITA_TRIB * :ALIQUOTA / 100 , 2),1,ADD_MONTHS(TO_DATE(:DATA, :FORMAT_DATA),1) ,:MES_EXERCICIO_ITEM,:ANO_EXERCICIO,(SELECT ID_TRIBUTO_IMP FROM TRIBUTOS_IMP WHERE COD_TRIBUTO = :INFRACAO),0,0,CURRENT DATE)','') .. 
      iff(json.sigla == 0, ',VL_MULTA_PUN_LANC = 0',',VL_MULTA_PUN_LANC = ROUND((ROUND(:VL_RECEITA_TRIB * :ALIQUOTA / 100 , 2) - :VL_PAGO) * :SIGLA / 100, 2)') ..   
      iff(json.txMultaPunItem, ',TX_MULTA_PUN_ITEM = :TX_MULTA_PUN_ITEM','') ..           
      iff(json.item, ',COD_ITEM = :COD_ITEM','') ..                                    
      iff(json.idListaServico, ',ID_LISTA_SERVICO = :ID_LISTA_SERVICO','') ..
      iff(json.vl, ',VL_PRINC_PG = :VL_PAGO','') ..                                    
      iff(json.competencia, ',MES_EXERCICIO_ITEM = :MES_EXERCICIO_ITEM','') ..[[
    WHERE ID_CALC_INFRACAO = :ID_CALC_INFRACAO
  ]]
  local p = {
    {'ID_CALC_INFRACAO', 'ftInteger', json.idCalcInfracao},
    iff(json.exercicio, {'ANO_EXERCICIO','ftInteger', json.exercicio}, nil),
    iff(json.competencia, {'MES_EXERCICIO_ITEM','ftInteger', json.competencia}, nil),
    iff(json.receitaBruta, {'VL_REC_BRUTA', 'ftFloat', json.receitaBruta, 0}, nil),
    iff(json.receitaTributaria, {'VL_RECEITA_TRIB', 'ftFloat', json.receitaTributaria, 0}, nil),
    iff(json.idListaServico, {'ID_LISTA_SERVICO','ftInteger', json.idListaServico}, nil),
    iff(json.aliquota, {'ALIQUOTA', 'ftFloat', json.aliquota, 0}, nil),
    iff(json.item, {'COD_ITEM', 'ftString', json.item, nil, 10}, nil),
    iff(json.vlPago, {'VL_PAGO', 'ftFloat', json.vlPago}, {'VL_PAGO', 'ftFloat', 0}),
    iff(json.txMultaPunItem, {'TX_MULTA_PUN_ITEM', 'ftInteger', json.txMultaPunItem, 0}, nil),
    iff(json.sigla, {'SIGLA', 'ftInteger', json.sigla, 0}, {'SIGLA', 'ftInteger', 0, 0}),
    iff(json.data, {'DATA', 'ftString', json.data, nil, 500}, nil),
    {'FORMAT_DATA', 'ftString', 'DD/MM/YYYY', nil, 500},
    {'INFRACAO', 'ftString', 'INFRACAO', nil, 500}
  }
  SQLExecute(q,p)  
end
--------------------------------------------------------------------------------
LANCAMENTOS_ITBI.Save = function(obj)
  if coalesce(obj.idInfracaoITBI, 0) == 0 then
    return  LANCAMENTOS_ITBI.Insert(obj)
  else
    return LANCAMENTOS_ITBI.Update(obj)
  end
end
--------------------------------------------------------------------------------
LANCAMENTOS_ITBI.Insert = function(json)
  local qr = SQLSelect('SELECT SEQ_INFRACOES_ITBI.NEXTVAL AS ID FROM PAR_INSTITUICAO')
  SQLExecute([[
    INSERT INTO INFRACOES_ITBI(
  ID_INFRACAO_ITBI, ID_AUTO_INFRACAO, OPERACAO_TAB, OPERACAO_ITEM, CADASTRO_TAB, 
  CADASTRO_ITEM, DT_FATO_GERADOR, ID_UNIDADE_IMOB, LOCAL_IMOVEL, VL_IMOVEL_AV_ORI, 
  VL_IMOVEL_AV_AT, VL_IMOVEL_INF_ORI, 
  VL_DEVIDO, VL_PAGO_OR, VL_JUROS, VL_MULTA, 
  VL_CORRECAO, VL_TOTAL_INFRA, 
  COD_OPERADOR, DT_ALTERACAO, 
  HR_ALTERACAO, CONCORRENCIA,  
  ID_ITBI, DESCR_ITBI, DT_REGISTRO, FRACAO_TRANSMITIDA_ORI, 
  FRACAO_TRANSMITIDA_RET, VL_FINANCIADO_ORI, VL_FINANCIADO_RET, VL_INTEGRALIZACAO_CAPITAL_ORI, VL_INTEGRALIZACAO_CAPITAL_RET, 
  OPERACAO_RET_TAB, OPERACAO_RET_ITEM, VL_ITBI_ORI, VL_ITBI_RET) 
    VALUES(
  :ID_INFRACAO_ITBI, :ID_AUTO_INFRACAO, 197, :OPERACAO_ITEM, 458, 
  :OPERACAO_ITEM, :DT_FATO_GERADOR, :ID_UNIDADE_IMOB, :LOCAL_IMOVEL, :VL_IMOVEL_AV_ORI, 
  :VL_IMOVEL_AV_AT, :VL_IMOVEL_INF_ORI,
  :VL_DEVIDO, :VL_PAGO_OR, :VL_JUROS, :VL_MULTA, 
  :VL_CORRECAO, :VL_TOTAL_INFRA,
  :CTX_ID_USUARIO, CURRENT DATE, 
  CURRENT TIME, 0,
  :ID_ITBI, :DESCR_ITBI, :DT_REGISTRO, :FRACAO_TRANSMITIDA_ORI, 
  :FRACAO_TRANSMITIDA_RET, :VL_FINANCIADO_ORI, :VL_FINANCIADO_RET, :VL_INTEGRALIZACAO_CAPITAL_ORI, :VL_INTEGRALIZACAO_CAPITAL_RET, 
  197, :OPERACAO_RET_ITEM, :VL_ITBI_ORI, :VL_ITBI_RET)]], {
    --params
    {'ID_INFRACAO_ITBI', 'ftInteger', qr[1].ID, 0},                    
    {'ID_AUTO_INFRACAO', 'ftInteger', json.idAutoInfracao, 0}, 
    {'OPERACAO_ITEM', 'ftInteger', json.operacao, 0},
    {'CADASTRO_ITEM', 'ftInteger', json.origemCadastro, 0},
    {'DT_FATO_GERADOR', 'ftString', json.dtRegistroReti},  
    {'ID_UNIDADE_IMOB', 'ftInteger', json.idUnidadeImob, 0},              
    {'LOCAL_IMOVEL', 'ftMemo', json.localImovel, 0}, 
    {'VL_IMOVEL_AV_ORI', 'ftFloat', json.vlAvaliadoTransacao, 0},    
    {'VL_IMOVEL_AV_AT', 'ftFloat', json.vlTransacaoReti, 0},
    {'VL_IMOVEL_INF_ORI', 'ftFloat', json.vlTransacao, 0}, 
    {'VL_DEVIDO', 'ftFloat', json.vlDevidoReti, 0},
    {'VL_PAGO_OR', 'ftFloat', json.vlPago, 0},
    {'VL_JUROS', 'ftFloat', json.vlJurosReti, 0},  
    {'VL_MULTA', 'ftFloat', json.vlMultaReti, 0},  
    {'VL_CORRECAO', 'ftFloat', json.vlCorrecaoReti, 0}, 
    iff(json.vlTotalInfracaoReti, {'VL_TOTAL_INFRA', 'ftFloat', json.vlTotalInfracaoReti}, {'VL_TOTAL_INFRA', 'ftFloat', 0}),   
    {'ID_ITBI', 'ftInteger', json.nroGuiaITBI, 0},
    {'DESCR_ITBI', 'ftMemo', json.descrComplementar, 0},
    {'DT_REGISTRO', 'ftString', json.dtRegistro},  
    {'FRACAO_TRANSMITIDA_ORI', 'ftFloat', json.fracaoTransmitida, 0},                 
    {'FRACAO_TRANSMITIDA_RET', 'ftFloat', json.fracaoTransmitidaReti, 0}, 
    {'VL_FINANCIADO_ORI', 'ftFloat', json.vlFinanciado, 0},   
    {'VL_FINANCIADO_RET', 'ftFloat', json.vlFinanciadoReti, 0},
    {'VL_INTEGRALIZACAO_CAPITAL_ORI', 'ftFloat', json.vlIntegralizacaoCapital, 0}, 
    {'VL_INTEGRALIZACAO_CAPITAL_RET', 'ftFloat', json.vlIntegralizacaoCapitalReti, 0},
    {'OPERACAO_RET_ITEM', 'ftInteger', json.operacaoReti, 0},
    {'VL_ITBI_ORI', 'ftFloat', json.vlITBI, 0},  
    {'VL_ITBI_RET', 'ftFloat', json.vlITBIReti, 0}
  })
  return qr[1].ID
end
--------------------------------------------------------------------------------
LANCAMENTOS_ITBI.Update = function(json)
  local q = [[
    UPDATE INFRACOES_ITBI SET               
      ID_INFRACAO_ITBI = :ID_INFRACAO_ITBI]] ..
      iff(json.idAutoInfracao, ',ID_AUTO_INFRACAO = :ID_AUTO_INFRACAO','') ..
      iff(json.operacao, ',OPERACAO_ITEM = :OPERACAO_ITEM','') ..      
      iff(json.origemCadastro, ',CADASTRO_ITEM = :CADASTRO_ITEM','') ..
      iff(json.dtRegistroReti, ',DT_FATO_GERADOR = :DT_FATO_GERADOR','') ..
      iff(json.idUnidadeImob, ',ID_UNIDADE_IMOB = :ID_UNIDADE_IMOB','') ..     
      iff(json.localImovel, ',LOCAL_IMOVEL = :LOCAL_IMOVEL','') ..
      iff(json.vlAvaliadoTransacao, ',VL_IMOVEL_AV_ORI = :VL_IMOVEL_AV_ORI','') ..           
      iff(json.vlTransacaoReti, ',VL_IMOVEL_INF_ORI = :VL_IMOVEL_INF_ORI','') ..            
      iff(json.vlTransacao, ',VL_IMOVEL_AV_AT = :VL_IMOVEL_AV_AT','') ..          
      iff(json.vlDevidoReti, ',VL_DEVIDO  = :VL_DEVIDO ','') ..
      iff(json.vlPago, ',VL_PAGO_OR = :VL_PAGO_OR','') ..
      iff(json.vlJurosReti, ',VL_JUROS = :VL_JUROS','') ..      
      iff(json.vlMultaReti, ',VL_MULTA = :VL_MULTA','') ..
      iff(json.vlCorrecaoReti, ',VL_CORRECAO = :VL_CORRECAO','') ..
      iff(json.vlTotalInfracaoReti, ',VL_TOTAL_INFRA = :VL_TOTAL_INFRA','') ..   
      iff(json.nroGuiaITBI, ',ID_ITBI = :ID_ITBI','') ..           
      iff(json.descrComplementar, ',DESCR_ITBI = :DESCR_ITBI','') ..            
      iff(json.dtRegistro, ',DT_REGISTRO = :DT_REGISTRO','') ..        
      iff(json.fracaoTransmitida, ',FRACAO_TRANSMITIDA_ORI = :FRACAO_TRANSMITIDA_ORI','') ..
      iff(json.fracaoTransmitidaReti, ',FRACAO_TRANSMITIDA_RET = :FRACAO_TRANSMITIDA_RET','') ..
      iff(json.vlFinanciado, ',VL_FINANCIADO_ORI = :VL_FINANCIADO_ORI','') ..      
      iff(json.vlFinanciadoReti, ',VL_FINANCIADO_RET = :VL_FINANCIADO_RET','') ..
      iff(json.vlIntegralizacaoCapitalReti, ',VL_INTEGRALIZACAO_CAPITAL_ORI = :VL_INTEGRALIZACAO_CAPITAL_ORI','') ..
      iff(json.vlDevidoReti, ',VL_INTEGRALIZACAO_CAPITAL_RET = :VL_INTEGRALIZACAO_CAPITAL_RET','') ..     
      iff(json.operacaoReti, ',OPERACAO_RET_ITEM = :OPERACAO_RET_ITEM','') ..     
      iff(json.vlITBI, ',VL_ITBI_ORI = :VL_ITBI_ORI','') ..                                            
      iff(json.vlITBIReti, ',VL_ITBI_RET = :VL_ITBI_RET','') ..[[
    WHERE ID_INFRACAO_ITBI = :ID_INFRACAO_ITBI
  ]]
  local p = {
    
    {'ID_INFRACAO_ITBI', 'ftInteger', json.idInfracaoITBI, 0},                    
    {'ID_AUTO_INFRACAO', 'ftInteger', json.idAutoInfracao, 0}, 
    {'OPERACAO_ITEM', 'ftInteger', json.operacao, 0},
    {'CADASTRO_ITEM', 'ftInteger', json.origemCadastro, 0},
    {'DT_FATO_GERADOR', 'ftString', json.dtRegistroReti},  
    {'ID_UNIDADE_IMOB', 'ftInteger', json.idUnidadeImob, 0},              
    {'LOCAL_IMOVEL', 'ftMemo', json.localImovel, 0}, 
    {'VL_IMOVEL_AV_ORI', 'ftFloat', json.vlAvaliadoTransacao, 0},    
    {'VL_IMOVEL_AV_AT', 'ftFloat', json.vlTransacaoReti, 0},
    {'VL_IMOVEL_INF_ORI', 'ftFloat', json.vlTransacao, 0}, 
    {'VL_DEVIDO', 'ftFloat', json.vlDevidoReti, 0},
    {'VL_PAGO_OR', 'ftFloat', json.vlPago, 0},
    {'VL_JUROS', 'ftFloat', json.vlJurosReti, 0},  
    {'VL_MULTA', 'ftFloat', json.vlMultaReti, 0},  
    {'VL_CORRECAO', 'ftFloat', json.vlCorrecaoReti, 0}, 
    iff(json.vlTotalInfracaoReti, {'VL_TOTAL_INFRA', 'ftFloat', json.vlTotalInfracaoReti}, {'VL_TOTAL_INFRA', 'ftFloat', 0}),   
    {'ID_ITBI', 'ftInteger', json.nroGuiaITBI, 0},
    {'DESCR_ITBI', 'ftMemo', json.descrComplementar, 0},
    {'DT_REGISTRO', 'ftString', json.dtRegistro},  
    {'FRACAO_TRANSMITIDA_ORI', 'ftFloat', json.fracaoTransmitida, 0},                 
    {'FRACAO_TRANSMITIDA_RET', 'ftFloat', json.fracaoTransmitidaReti, 0}, 
    {'VL_FINANCIADO_ORI', 'ftFloat', json.vlFinanciado, 0},   
    {'VL_FINANCIADO_RET', 'ftFloat', json.vlFinanciadoReti, 0},
    {'VL_INTEGRALIZACAO_CAPITAL_ORI', 'ftFloat', json.vlIntegralizacaoCapital, 0}, 
    {'VL_INTEGRALIZACAO_CAPITAL_RET', 'ftFloat', json.vlIntegralizacaoCapitalReti, 0},
    {'OPERACAO_RET_ITEM', 'ftInteger', json.operacaoReti, 0},
    {'VL_ITBI_ORI', 'ftFloat', json.vlITBI, 0},  
    {'VL_ITBI_RET', 'ftFloat', json.vlITBIReti, 0}
  }
  SQLExecute(q,p) 
  
  return json.idInfracaoITBI
end
--------------------------------------------------------------------------------
function epat.getDataSourceVariaveis()
  dsVariaveis = {[[ [
      {
        "DESCRICAO": "Nº do Processo", 
        "TAG": "<NUM_PROCESSO>",
        "ABA": "IDENTIFICAÇÃO DO AUTO"   
      },{
        "DESCRICAO": "Descrição Doc. Autuação",
        "TAG": "<DESCR_DOC_AUTUACAO>",
        "ABA": "IDENTIFICAÇÃO DO AUTO"   
      },{
        "DESCRICAO": "Data da Autuação",
        "TAG": "<DT_AUTUACAO>",
        "ABA": "IDENTIFICAÇÃO DO AUTO"                 
      },{
        "DESCRICAO": "Hora da Autuação", 
        "TAG": "<HR_AUTUACAO>",
        "ABA": "IDENTIFICAÇÃO DO AUTO"   
      },{
        "DESCRICAO": "Local da Autuação",
        "TAG": "<LOCAL_AUTUACAO>",
        "ABA": "IDENTIFICAÇÃO DO AUTO"   
      },{
        "DESCRICAO": "Matrícula Auditor",
        "TAG": "<AUDITOR_MATRICULA>",
        "ABA": "IDENTIFICAÇÃO DO AUTO"                 
      },{
        "DESCRICAO": "Nome Auditor", 
        "TAG": "<AUDITOR_NOME>",
        "ABA": "IDENTIFICAÇÃO DO AUTO"   
      },{
        "DESCRICAO": "Cargo do Auditor",
        "TAG": "<AUDITOR_CARGO>",
        "ABA": "IDENTIFICAÇÃO DO AUTO"   
      },{
        "DESCRICAO": "ID do Contribuinte",
        "TAG": "<ID_CONTRIBUINTE>",
        "ABA": "IDENTIFICAÇÃO DO AUTO"                 
      },{
        "DESCRICAO": "Nome Contribuinte", 
        "TAG": "<NOME_CONTRIBUINTE>",
        "ABA": "IDENTIFICAÇÃO DO AUTO"   
      },{
        "DESCRICAO": "Documento Contribuinte",
        "TAG": "<CPF_CNPJ_CONTRIBUINTE>",
        "ABA": "IDENTIFICAÇÃO DO AUTO"   
      },{
        "DESCRICAO": "Nº da Inscrição",
        "TAG": "<INSCRICAO>",
        "ABA": "IDENTIFICAÇÃO DO AUTO"                 
      },{
        "DESCRICAO": "Base de cálculo", 
        "TAG": "<AL_VL_BASE_CALCULO>",
        "ABA": "INFRAÇÕES E LANÇAMENTOS"   
      },{
        "DESCRICAO": "Valor Devido",
        "TAG": "<AL_VL_DEVIDO>",
        "ABA": "INFRAÇÕES E LANÇAMENTOS"   
      },{
        "DESCRICAO": "Valor Pago",
        "TAG": "<AL_VL_PAGO>",
        "ABA": "INFRAÇÕES E LANÇAMENTOS"                 
      },{
        "DESCRICAO": "Valor ISS", 
        "TAG": "<AL_VL_ISS>",
        "ABA": "INFRAÇÕES E LANÇAMENTOS"   
      },{
        "DESCRICAO": "Tx. multa punitiva",
        "TAG": "<AL_VL_MULTA_PUN>",
        "ABA": "INFRAÇÕES E LANÇAMENTOS"   
      },{
        "DESCRICAO": "Competência",
        "TAG": "<AL_COMPETENCIAS>",
        "ABA": "INFRAÇÕES E LANÇAMENTOS"                 
      },{
        "DESCRICAO": "Serviço", 
        "TAG": "<AL_COD_SERVICOS>",
        "ABA": "INFRAÇÕES E LANÇAMENTOS"   
      },{
        "DESCRICAO": "Descrição da Infração",
        "TAG": "<AI_DESCR_INFRACAO_>",
        "ABA": "INFRAÇÕES"   
      },{
        "DESCRICAO": "Capitulação Legal",
        "TAG": "<AI_CAPITULACAO_LEGAL_>",
        "ABA": "INFRAÇÕES"                 
      },{
        "DESCRICAO": "Nº do item", 
        "TAG": "<AI_NUM_ITEM_>",
        "ABA": "INFRAÇÕES"   
      },{
        "DESCRICAO": "Nº de ocorrências",
        "TAG": "<AI_NUM_OCORRENCIAS_>",
        "ABA": "INFRAÇÕES"   
      },{
        "DESCRICAO": "Vl. da infração",
        "TAG": "<AI_VL_INFRACAO_>" ,
        "ABA": "INFRAÇÕES"                
      },{
        "DESCRICAO": "Vl. total", 
        "TAG": "<AI_TOTAL_>",
        "ABA": "INFRAÇÕES"   
      },{
        "DESCRICAO": "Nº da Guia de ITBI",
        "TAG": "<ITBI_NUM_GUIA>",
        "ABA": "LANÇAMENTOS DE ITBI"   
      },{
        "DESCRICAO": "Origem do cadastro",
        "TAG": "<ITBI_ORIGEM_CADASTRO>",
        "ABA": "LANÇAMENTOS DE ITBI"                 
      },{
        "DESCRICAO": "Inscrição do Imóvel", 
        "TAG": "<ITBI_INSCRICAO_IMOVEL>",
        "ABA": "LANÇAMENTOS DE ITBI"   
      },{
        "DESCRICAO": "Local imóvel",
        "TAG": "<ITBI_LOCAL_IMOVEL>",
        "ABA": "LANÇAMENTOS DE ITBI"   
      },{
        "DESCRICAO": "Descrição complementar",
        "TAG": "<ITBI_DESR_COMPLEMENTAR>",
        "ABA": "LANÇAMENTOS DE ITBI" 
      },{
        "DESCRICAO": "Operação Origem",
        "TAG": "<ITBI_OPERACAO_ORI>",
        "ABA": "LANÇAMENTOS DE ITBI"                 
      },{
        "DESCRICAO": "Data registro Origem", 
        "TAG": "<ITBI_DT_REGISTRO_ORI>",
        "ABA": "LANÇAMENTOS DE ITBI"   
      },{
        "DESCRICAO": "Fração transmitida Origem",
        "TAG": "<ITBI_FRACAO_TRANS_ORI>",
        "ABA": "LANÇAMENTOS DE ITBI"   
      },{
        "DESCRICAO": "Valor da transação Origem",
        "TAG": "<ITBI_VL_TRANSACAO_ORI>",
        "ABA": "LANÇAMENTOS DE ITBI"                 
      },{
        "DESCRICAO": "Valor financiado Origem", 
        "TAG": "<ITBI_VL_FINANCIADO_ORI>",
        "ABA": "LANÇAMENTOS DE ITBI"   
      },{
        "DESCRICAO": "Vl integralização Origem",
        "TAG": "<ITBI_VL_INTEGRALIZACAO_ORI>",
        "ABA": "LANÇAMENTOS DE ITBI"   
      },{
        "DESCRICAO": "Valor do ITBI",
        "TAG": "<ITBI_VL_ITBI_ORI>",
        "ABA": "LANÇAMENTOS DE ITBI"                 
      },{
        "DESCRICAO": "Valor Pago", 
        "TAG": "<ITBI_VL_PAGO>" ,
        "ABA": "LANÇAMENTOS DE ITBI"  
      },{
        "DESCRICAO": "Operação Retificação",
        "TAG": "<ITBI_OPERACAO_RET>" ,
        "ABA": "LANÇAMENTOS DE ITBI"  
      },{
        "DESCRICAO": "Data registro Retificação",
        "TAG": "<ITBI_DT_REGISTRO_RET>",
        "ABA": "LANÇAMENTOS DE ITBI"                 
      },{
        "DESCRICAO": "Fração transmitida Retificação", 
        "TAG": "<ITBI_FRACAO_TRANS_RET>",
        "ABA": "LANÇAMENTOS DE ITBI"   
      },{
        "DESCRICAO": "Valor financiado Retificação",
        "TAG": "<ITBI_VL_FINANCIADO_RET>",
        "ABA": "LANÇAMENTOS DE ITBI"   
      },{
        "DESCRICAO": "Vl integralização Retificação",
        "TAG": "<ITBI_VL_INTEGRALIZACAO_RET>",
        "ABA": "LANÇAMENTOS DE ITBI"                 
      },{
        "DESCRICAO": "Valor do ITBI Retificação", 
        "TAG": "<ITBI_VL_ITBI_RET>",
        "ABA": "LANÇAMENTOS DE ITBI"   
      },{
        "DESCRICAO": "Valor Devido Retificação",
        "TAG": "<ITBI_VL_DEVIDO>",
        "ABA": "LANÇAMENTOS DE ITBI"   
      },{
        "DESCRICAO": "Valor Correção",
        "TAG": "<ITBI_VL_CORRECAO>",
        "ABA": "LANÇAMENTOS DE ITBI"                 
      },{
        "DESCRICAO": "Valor Juros", 
        "TAG": "<ITBI_VL_JUROS>" ,
        "ABA": "LANÇAMENTOS DE ITBI"  
      },{
        "DESCRICAO": "Valor Multa",
        "TAG": "<ITBI_VL_MULTA>" ,
        "ABA": "LANÇAMENTOS DE ITBI"  
      },{
        "DESCRICAO": "Valor Total Infração",
        "TAG": "<ITBI_VL_TOTAL_INFRACAO>",
        "ABA": "LANÇAMENTOS DE ITBI"                 
      }
    ] ]]}
    
    return dsVariaveis 
end 
---------------------------------------------------------------------------------------------------------------------
--Atualiza o nome da pessoa ou Inclui a PESSOA e DOCUMENTO
TrataPessoa = function(NomePessoa, NumDoc)
  NumDoc = trim(coalesce(NumDoc, '')) 
  if NumDoc ~= '' then     
    qrGetIdPessoa = SQLSelect("SELECT ID_PESSOA FROM DOC_PESSOAS WHERE NUMERO_DOCUMENTO = " .. DB.GetStringOrNull(NumDoc))
  end  
  NomePessoa = DB.GetStringOrNull(uppercase(NomePessoa),80)
  if NumDoc ~= '' and qrGetIdPessoa then
    --ATUALIZA O NOME DA PESSOA    
    IdP = qrGetIdPessoa[1].ID_PESSOA 
    SQLExecute("UPDATE PESSOAS P SET NOME_PESSOA = " .. NomePessoa .. ", NOME_PESSOA_UP = " .. NomePessoa .. " WHERE ID_PESSOA = " .. qrGetIdPessoa[1].ID_PESSOA .. [[
               AND NOT EXISTS (
                 SELECT 1 FROM CONTRIBUINTES_IMOB X WHERE X.ID_PESSOA = P.ID_PESSOA
                 UNION ALL
                 SELECT 1 FROM FUNCIONARIOS X WHERE X.ID_PESSOA = P.ID_PESSOA
                 UNION ALL
                SELECT 1 FROM FORNECEDORES X WHERE X.ID_PESSOA = P.ID_PESSOA)    
              ]])
              
  else
    --INCLUI A PESSOA E O DOCUMENTO
    qrGetIdPessoa = SQLSelect("SELECT SEQ_PESSOAS.NEXTVAL AS ID_PESSOA FROM PAR_INSTITUICAO")
    IdP = qrGetIdPessoa[1].ID_PESSOA
    if consisteCPF(NumDoc) then
      nj = 'F'
      td = 'CPF'
    else
      nj = 'J'
      td ='CNPJ'
    end
    
    local qr = [[
    INSERT INTO PESSOAS (
      ID_PESSOA, --1
      NOME_PESSOA, --2
      NOME_PESSOA_UP, --3
      NATUREZA_JURIDICA, --4
      COD_OPERADOR,DT_ALTERACAO,HR_ALTERACAO,CONCORRENCIA) --5
    VALUES (
    ]]
    .. IdP .. "," --1
    .. "" .. NomePessoa .. "," --2
    .. "" .. NomePessoa .. "," -- 3
    .. "'" .. nj .. "'," -- 4
    .. getidusuario() .. ", CURRENT DATE, CURRENT TIME, 0)" --5
    --salvalog(qr)  
    SQLExecute(qr)
    
    qr = [[
    INSERT INTO DOC_PESSOAS (
      ID_DOC_PESSOA, --1
      ID_TDOC_PESSOA, --2
      ID_PESSOA, --3
      NUMERO_DOCUMENTO, --4
      COD_OPERADOR, DT_ALTERACAO, HR_ALTERACAO, CONCORRENCIA) --5
    VALUES (
      SEQ_DOC_PESSOAS.NEXTVAL, --1
      (SELECT ID_TDOC_PESSOA FROM TIPOS_DOC_PESSOAS WHERE SIGLA_TDOC_PESSOA = ']] .. td.. "')," --2
      .. IdP .. "," --3
      .. DB.GetStringOrNull(NumDoc) .. "," --4 
      .. getidusuario() .. ", CURRENT DATE, CURRENT TIME, 0)" --5

    --salvalog(qr)
    SQLExecute(qr)               
  end
  
  return IdP   
end
-----------------------------------------------------------------------------------------------------------
--Inclui ou atualiza o ENDERECO conforme o tipo de cadastro
TrataEndereco = function(obj)
    local IdEnd = coalesce(obj.idEndereco, 0)
    local Cep = DB.GetStringOrNull(replace(trim(coalesce(obj.cep, "")), "-", ""), 8, "")
    local Rua = DB.GetStringOrNull(obj.rua, 60, "")
    local Numero = DB.GetStringOrNull(obj.numero, 10, "")
    local Complemento = DB.GetStringOrNull(obj.complemento, 60, "")
    local Bairro = DB.GetStringOrNull(obj.bairro, 60, "")
    local Municipio = DB.GetStringOrNull(obj.municipio, 60, "")
    local UF = DB.GetStringOrNull(obj.uf, 2, "")
    local TipoLogradTab = 134
    local TipoLogradItem = DB.GetNumberOrNull(coalesce(obj.tipoLogradouroItem, 9999), 0)
    local TipoEndItem = DB.GetNumberOrNull(coalesce(obj.tipoEndItem, 1), 0)
    local IdOrigem = coalesce(obj.idPessoa, 0)
    local TipoOrigemItem = 28
    local TipoEnd = DB.GetStringOrNull(obj.tipoEnd, 1, "")
    --salvalog(IdEnd)   
    if IdEnd == 0 then    
        local qrIdEnd = SQLSelect("SELECT SEQ_ENDERECOS.NEXTVAL AS ID_ENDERECO FROM PAR_INSTITUICAO")
        IdEnd = qrIdEnd[1].ID_ENDERECO
        local qr = [[
        INSERT INTO ENDERECOS (
        ID_ENDERECO, --1
        TIPO_ORIGEM_TAB, TIPO_ORIGEM_ITEM, --2
        TIPO_ENDERECO, --3
        DESCR_RUA, --4
        DESCR_NUMERO, --5
        DESCR_COMPLEMENTO, --6
        DESCR_BAIRRO, --7
        DESCR_MUNICIPIO, --8      
        DESCR_UF, --9
        DESCR_CEP, --10
        TIPO_LOGRAD_TAB, TIPO_LOGRAD_ITEM, --11        
        TIPO_END_TAB, TIPO_END_ITEM, --12
        IND_CORRESP, --13,
        ID_ORIGEM, --14
        ID_CIDADE, --15,
        PAIS_BACEN_ITEM, --16
        DESCR_ESTADO, --17
        PAIS_BACEN_TAB, --18
        COD_OPERADOR, DT_ALTERACAO, HR_ALTERACAO, CONCORRENCIA) --19 
        VALUES (
        ]]
        .. IdEnd .. "," --1
        .. 141 .. "," .. TipoOrigemItem .. "," --2
        .. TipoEnd .. "," --3
        .. Rua .. "," --4
        .. Numero .. "," --5
        .. Complemento .. "," --6
        .. Bairro .. "," --7
        .. Municipio .. "," --8
        .. UF .. "," --9
        .. Cep .. "," --10
        .. TipoLogradTab .. "," .. TipoLogradItem .. "," -- 11      
        .. 240 .. "," .. TipoEndItem .. ',' -- 12
        .. "'N'," -- 13
        .. IdOrigem .. "," --14
        .. DB.GetNumberOrNull(obj.idCidade) .. "," --15
        .. 1058 .. "," --16
        .. DB.GetStringOrNull(obj.estado, 60, "") .. "," --17
        .. 9674 .. "," --18
        .. getidusuario() .. ", CURRENT DATE, CURRENT TIME, 0)" --19
        --salvalog(qr)
        SQLExecute(qr)
    else

        local qr = "UPDATE ENDERECOS SET"
        .."    TIPO_LOGRAD_TAB = " .. TipoLogradTab .. ","
        .."    TIPO_LOGRAD_ITEM = " .. TipoLogradItem .. ","
        .."    DESCR_RUA = " .. Rua .. ","
        .."    DESCR_NUMERO = " .. Numero .. ","
        .."    DESCR_COMPLEMENTO = " .. Complemento .. "," 
        .."    DESCR_BAIRRO = " .. Bairro .. ","
        .."    DESCR_MUNICIPIO = " .. Municipio .. ","
        .."    DESCR_UF = " .. UF .. ","
        .."    DESCR_CEP = " .. Cep .. ","
        ..iff(coalesce(obj.idCidade,0) > 0, "ID_CIDADE = " .. DB.GetNumberOrNull(obj.idCidade,0) .. ",", "")
        .."    ID_ORIGEM = " .. IdOrigem .. ","
        .."    TIPO_ORIGEM_ITEM = " .. TipoOrigemItem .. ","
        .."    TIPO_END_ITEM = " .. TipoEndItem .. ","
        .." WHERE ID_ENDERECO = " .. IdEnd

        --salvalog(qr)
        SQLExecute(qr)  
    end       
    return IdEnd
end  
---------------------------------------------------------------------------------------------------------------
InsertContribuinteImob = function(obj)

  if obj.naturezaJuridica == 'CPF' then
    nj = 'F'
  else
    nj = 'J'
  end

  local qrSeq = SQLSelect('SELECT SEQ_CONTRIBUINTES_IMOB.NEXTVAL AS ID_CONTRIBUINTE FROM PAR_INSTITUICAO')
  SQLExecute([[
    INSERT INTO CONTRIBUINTES_IMOB (
      ID_CONTRIBUINTE, ID_PESSOA, NOME_CONTRIBUINTE, CPF_CNPJ_RG, CPF_CNPJ_SEM_MASCARA, NOME_FANTASIA, 
      NATUREZA_JURIDICA, IND_ESTABELECIDO, IND_SITUACAO,
      COD_OPERADOR, DT_ALTERACAO, HR_ALTERACAO, CONCORRENCIA)
    VALUES (
      :ID_CONTRIBUINTE, :ID_PESSOA, :NOME_CONTRIBUINTE, :CPF_CNPJ_RG, :CPF_CNPJ_RG_SEM_MASCARA, :NOME_CONTRIBUINTE, 
      :NATUREZA_JURIDICA, 'N', 'A',
      :CTX_ID_USUARIO, CURRENT DATE, CURRENT TIME, 0)]], {
    --params
    {'ID_CONTRIBUINTE', 'ftInteger', qrSeq[1].ID_CONTRIBUINTE},
    {'ID_PESSOA', 'ftInteger', obj.idPessoa, 0},
    {'NOME_CONTRIBUINTE', 'ftString', obj.nome, '', 254},
    {'CPF_CNPJ_RG', 'ftString', obj.numDoc, '', 20},
    {'CPF_CNPJ_RG_SEM_MASCARA', 'ftString', obj.numDocSemMascara, '', 20},
    {'NATUREZA_JURIDICA', 'ftString', nj, '', 1}
  })
  return qrSeq[1].ID_CONTRIBUINTE
end