--[[
Faça um programa que pergunte o preço de três produtos e informe qual produto
você deve comprar, sabendo que a decisão é sempre pelo mais barato.
--]]
print("Digite o valor do primeiro produto: ")
preco1 = tonumber(io.read())
print("Digite o valor do segundo produto: ")
preco2 = tonumber(io.read())
print("Digite o valor do terceiro produto: ")
preco3 = tonumber(io.read())
if preco1 < preco2 and preco1 < preco3 then
    print("O produto com menor preço é o 1, custando R$".. preco1)
elseif preco2 < preco1 and preco2 < preco3 then
    print("O produto com menor preco é o 2, custando R$".. preco2)
else
    print("O produto com menor valor é o 3, custando R$".. preco3)
end