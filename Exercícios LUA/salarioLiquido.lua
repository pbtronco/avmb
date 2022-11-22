--[[
Faça um Programa que pergunte quanto você ganha por hora e o número de horas
trabalhadas no mês.
Calcule e mostre o total do seu salário no referido mês,
sabendo-se que são descontados 11% para o Imposto de Renda,
8% para o INSS e 5% para o sindicato, faça um programa que nos dê:
    salário bruto.
    quanto pagou ao INSS.
    quanto pagou ao sindicato.
    o salário líquido.
calcule os descontos e o salário líquido, conforme a tabela abaixo:
    + Salário Bruto : R$
    - IR (11%) : R$
    - INSS (8%) : R$
    - Sindicato ( 5%) : R$
    = Salário Liquido : R$
Obs.: Salário Bruto - Descontos = Salário Líquido.
--]]
print("Digite quanto você ganha por hora")
salarioHora = tonumber(io.read())
print("Digite a quantidade de horas trabalhadas por mês")
horasTrabalhadas = tonumber(io.read())
salarioMes = salarioHora * horasTrabalhadas
IR = salarioMes * (11 / 100)
INSS = salarioMes * (8 / 100)
sindicato = salarioMes * (8 / 100)
salarioLiquido = salarioMes - IR - INSS - sindicato
print(string.format("+ Salário Bruto : R$%.2f", salarioMes))
print(string.format("- IR (11%%) : R$%.2f", IR))
print(string.format("- INSS (8%%) : R$%.2f", INSS))
print(string.format("- Sindicato (5%%) : R$%.2f", sindicato))
print(string.format("= Salário Liquido : R$%.2f", salarioLiquido))
