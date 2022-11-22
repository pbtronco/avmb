local x = {1, 2, 3, 4, 5}
local i
local media = 0

for i = 1, getn(x) do
    media= media + x[i]
end
print('O total é: ', media)
media = media / getn(x)

print('A média é: ', media)