--[[
Faça um Programa que peça a temperatura em graus Farenheit, transforme e mostre
a temperatura em graus Celsius.
C = (5 * (F-32) / 9).
--]]
print("Digite a temperatura em Farenheit")
tempF = tonumber(io.read())
tempC = (5 * (tempF - 32) / 9 )
print("Temperatura em Celsius: ".. tempC .. "°C")