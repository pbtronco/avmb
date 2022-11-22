local string= {'p','a','b','l','o',' ','b','o','r','g','e','s',' ','t','r','o','n','c','o'}
local i
local newString= {}

for i=1, getn(string) do
             if i == 1 then
                newString[i]= uppercase(string[i])
             else if string[i] == " " then
                newString[i]= " "
                newString[i+1]= uppercase(string[i+1])
                i= i + 1
             else
                newString[i]= lowercase(string[i])
             end
             end
end

for i=1, getn(newString) do
    print(newString[i])
end