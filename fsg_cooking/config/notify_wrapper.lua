-- Wrap lib.notify so every notification in this resource uses top-center.
-- Loaded as a shared_script so it applies to both client and server.
if lib and lib.notify then
    local _notify = lib.notify
    lib.notify = function(a, b)
        if type(a) == 'table' then
            -- client: lib.notify(data)
            a.position = a.position or 'top-center'
            return _notify(a)
        elseif type(b) == 'table' then
            -- server: lib.notify(source, data)
            b.position = b.position or 'top-center'
            return _notify(a, b)
        end
        return _notify(a, b)
    end
end
