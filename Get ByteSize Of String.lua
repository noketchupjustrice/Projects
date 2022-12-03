local GetByteSize = function(String)
    return #({String:byte(1, -1)})
end

local String = "Hello"

print(GetByteSize(String)) --Byte Size Is 5
