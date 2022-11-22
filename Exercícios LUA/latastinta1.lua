--[[
Faça um programa para uma loja de tintas.
O programa deverá pedir o tamanho em metros quadrados da área a ser pintada.
Considere que a cobertura da tinta é de 1 litro para cada 3 metros
quadrados e que a tinta é vendida em latas de 18 litros, que custam R$ 80,00.
Informe ao usuário a quantidades de latas de tinta
a serem compradas e o preço total.
--]]
print("Digite o valor da área em metros quadrados")
area = tonumber(io.read())
rendimentoDaTinta = 3 -- 1 litro rende 3 metros quadrados
litrosNaLata = 18
precoDaLata = 80.00
latasAComprar = math.ceil(area / (rendimentoDaTinta * litrosNaLata))
precoTotal = latasAComprar * precoDaLata
print(
    string.format(
    "Você tera que comprar %i lata(s), gastando R$%.2f", latasAComprar, precoTotal
    )
)
