--[[numero maior que outro]]
print("Digite um número: ")
n1 = tonumber(io.read())

if n1 > 0 then
    print("positivo")
elseif n1 < 0 then
    print("negativo")
else
    print("igual a 0")
end