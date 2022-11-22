local x = {1, 2, 3, 4, 5}
local i
local maior, menor = 0, 0

for i = 1, getn(x) do
    if i == 1 then
    maior= x[i]
    menor= x[i]
    end
    if maior < x[i] then
       maior = x[i]
    else if menor > x[i] then
         menor = x[i]
    end
    end
end
print('O maior numero é: ', maior)
print('O menor numero é: ', menor)