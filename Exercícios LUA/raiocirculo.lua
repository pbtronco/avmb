print("Digite o raio do círculo: ")
raio = tonumber(io.read())
area = math.pi * math.pow(raio, 2)
print(string.format("A area é: %.2f", area))