
-- Long format
minetest.register_chatcommand("laston", {
    privs = {
        shout = true,
    },
    description = "Displays a given playername's last time on. (In a long format)",
    func = function(name, param)
        if param == "" then
            return false, "Requires a playername as 2nd parameter."
        end
        local struct = laston.get(param)
        if struct.on == 0 and struct.pt == 0 and struct.off == 0 then
            return false, "Player not found."
        end
        if struct.off == 0 then
            return true, "Player not found."
        end
        local diff = laston.since(struct.off)
        return true, laston.str_format(laston.format(diff))
    end,
})

-- Short format
minetest.register_chatcommand("lo", {
    privs = {
        shout = true,
    },
    description = "Displays a given playername's last time on. (In a short format)",
    func = function(name, param)
        if param == "" then
            return false, "Requires a playername as 2nd parameter."
        end
        local struct = laston.get(param)
        if struct.on == 0 and struct.pt == 0 and struct.off == 0 then
            return false, "Player not found."
        end
        if struct.off == 0 then
            return true, "Player not found."
        end
        local diff = laston.since(struct.off)
        return true, laston.short_str_format(laston.format(diff))
    end,
})

-- Long format
minetest.register_chatcommand("playtime", {
    privs = {
        shout = true,
    },
    description = "Displays you, or a given playername's total playtime. (In a long format)",
    func = function(name, param)
        if param == "" then
            param = name
        end
        local struct = laston.get(param)
        if struct.on == 0 and struct.pt == 0 and struct.off == 0 then
            return false, "Player not found."
        end
        if struct.pt == nil then
            struct.pt = 0
        end
        local diff = laston.since(struct.on) + struct.pt
        return true, laston.str_format(laston.format(diff))
    end,
})

-- Short format
minetest.register_chatcommand("pt", {
    privs = {
        shout = true,
    },
    description = "Displays you, or a given playername's total playtime. (In a short format)",
    func = function(name, param)
        if param == "" then
            param = name
        end
        local struct = laston.get(param)
        if struct.on == 0 and struct.pt == 0 and struct.off == 0 then
            return false, "Player not found."
        end
        if struct.pt == nil then
            struct.pt = 0
        end
        local diff = laston.since(struct.on) + struct.pt
        return true, laston.short_str_format(laston.format(diff))
    end,
})