
minetest.register_on_joinplayer(function(player, lo)
    local pname = player:get_player_name()
    local struct = laston.get(pname)
    struct.on = laston.now()
    laston.set(pname, struct)
    laston.log(pname .. " logged in")
end)

minetest.register_on_leaveplayer(function(player, timed_out)
    local pname = player:get_player_name()
    local struct = laston.get(pname)
    struct.pt = laston.since(struct.on) + struct.pt
    struct.off = laston.now()
    laston.set(pname, struct)
    laston.log(pname .. " logged out")
end)

minetest.register_on_shutdown(function()
    for idx, player in ipairs(minetest.get_connected_players()) do
        local pname = player:get_player_name()
        local struct = laston.get(pname)
        struct.pt = laston.since(struct.on) + struct.pt
        struct.off = laston.now()
        laston.set(pname, struct)
        laston.log(pname .. " logged out (server shutdown)")
    end
end)
