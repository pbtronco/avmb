--[[
Faça um Programa que peça a temperatura em graus Celsius, transforme e mostre
em graus Farenheit.
--]]
print("Digite a temperatura em Celsius: ")
tempC = tonumber(io.read())
tempF = (9 * tempC / 5) + 32
print(string.format("Isso equivale a %.2f graus Farenheit", tempF))