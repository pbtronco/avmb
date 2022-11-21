--[[
Faça um Programa que verifique se uma letra digitada é "F" ou "M".
Conforme a letra escrever: F - Feminino, M - Masculino, Sexo Inválido.
--]]
print("Digite o seu sexo: ")
sexo = io.read()
if sexo == "F" or sexo == "f" then
    print("Feminino")
elseif sexo == "M" or sexo == "m" then
    print("Masculino")
else
    print("Sexo Inválido")
end