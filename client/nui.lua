-- NUI helper class wrapping SendNUIMessage and RegisterNUICallback

Nui = lib.class('Nui')

function Nui:constructor()
    self.private = {}
end

-- Send a message to the NUI (browser)
function Nui:msg(action, data)
    SendNUIMessage({ action = action, data = data })
end

-- Register a NUI callback handler
function Nui:cb(name, handler)
    RegisterNUICallback(name, function(data, cb)
        handler(data, cb)
    end)
end
