
laston = {
    VERSION = "v1.0",
    store = minetest.get_mod_storage(),
    huds = {},
}

if minetest.get_modpath("default") ~= nil then
    laston.gamemode = "MTG"
elseif minetest.get_modpath("mcl_core") ~= nil then
    laston.gamemode = "MCL"
else
    laston.gamemode = "???"
end

laston.log = function(msg)
    if type(msg) == "table" then
        msg = minetest.serialize(msg)
    end
    minetest.log("action", "[laston] " .. msg)
end

laston.dofile = function(fname)
    local modpath = minetest.get_modpath("laston")
    dofile(modpath .. DIR_DELIM .. fname .. ".lua")
end

laston.log("Version: " .. laston.VERSION)

laston.dofile("api")
laston.dofile("routine")
laston.dofile("chat_cmd")

laston.log("Ready.")
