--[[Mostrar dias da semana]]
print("Digite 1-> Segunda 2-> Terça 3-> Quarta 4-> Quinta 5-> Sexta 6-> Sábado 7-> Domingo ")
diaInt = tonumber(io.read())
diaStr = ''
if diaInt == 1 then
    diaStr = 'Segunda'
elseif diaInt == 2 then
    diaStr = 'Terça'
elseif diaInt == 3 then
    diaStr = 'Quarta'
elseif diaInt == 4 then
    diaStr = 'Quinta'
elseif diaInt == 5 then
    diaStr = 'Sexta'
elseif diaInt == 6 then
    diaStr = 'Sábado'
elseif diaInt == 7 then
    diaStr = 'Domingo'
end

if diaStr == '' then
    print('Valor inválido')
else
    print(string.format('O dia correspondente é %s', diaStr))
end