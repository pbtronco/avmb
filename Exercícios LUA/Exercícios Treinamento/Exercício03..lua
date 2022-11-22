local x = {1, 2, 3, 4, 5}
local i, y
local impar= {}
local par = {}

for i = 1, getn(x) do
    if mod(x[i], 2) == 0 then
       par[i]= x[i]
    else
         impar[i] =x[i]
    end       
end
print('Par: ')
for i = 1, getn(par) do
    if par[i] == nil then
    else
    print(par[i])
    end
end
print('Impar: ')
for i = 1, getn(impar) do
    if impar[i] == nil then
    else
    print(impar[i])
    end
end