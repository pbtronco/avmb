--[[
Faça um programa que peça o tamanho de um arquivo para download (em MB) e a
velocidade de um link de Internet (em Mbps), calcule e informe o tempo
aproximado de download do arquivo usando este link (em minutos).
--]]
print("Digite o tamanho do arquivo em MB: ")
mb = tonumber(io.read())
print("Digite a velocidade da internet em Mbps")
mbps = tonumber(io.read())
tempo = mb / mbps
print(
    string.format(
        "O tempo aproximado para o download do arquivo é de %.0f segundos", tempo))