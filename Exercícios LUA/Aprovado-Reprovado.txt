--[[
Faça um programa para a leitura de duas notas parciais de um aluno.
O programa deve calcular a média alcançada por aluno e apresentar:
    A mensagem "Aprovado", se a média alcançada for maior ou igual a sete;
    A mensagem "Reprovado", se a média for menor do que sete;
    A mensagem "Aprovado com Distinção", se a média for igual a dez.
--]]
print("Digite o valor da primeira média: ")
n1 = tonumber(io.read())
print("Digite o valor da segunda média: ")
n2 = tonumber(io.read())
media = ( n1 + n2 ) / 2
if media == 10 then
    print("Aprovado com Distinção")
elseif media >= 7 then
    print("Aprovado")
else
    print("Reprovado")
end
