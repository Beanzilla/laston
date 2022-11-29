
-- Returns a structure of when the player logged on last and when they logged off
laston.get = function(player_name)
    local struct = laston.store:get_string("lo_"..player_name) or ""
    if struct ~= "" then
        return minetest.deserialize(struct)
    end
    return {on=0, pt=0, off=0}
end

-- Assigns a structure to the player
laston.set = function(player_name, struct)
    if struct == nil then
        struct = {on=0, pt=0, off=0}
    end
    laston.store:set_string("lo_"..player_name, minetest.serialize(struct))
end

-- Obtains a UNIX datetime stamp in local time (for the server)
laston.now = function()
    -- https://stackoverflow.com/questions/43857183/getting-utc-unix-timestamp-in-lua#43857313
    return os.time(os.date("*t")) -- in server local time
end

-- Obtains the number of seconds since the datetime stamp
laston.since = function(stamp)
    local now = laston.now()
    --[[laston.log("Now=   " .. now)
    laston.log("Stamp= " .. stamp)
    laston.log("diff=  " .. now-stamp)]]
    return math.abs(now - stamp)
end

laston.format = function(timestamp)
    local minutes = math.floor(timestamp / 60)
    timestamp = timestamp - (minutes * 60)
    local hours = math.floor(minutes / 60)
    minutes = minutes - (hours * 60)
    local days = math.floor(hours / 24)
    hours = hours - (days * 24)
    local weeks = math.floor(days / 7)
    days = days - (weeks * 7)

    return {week=weeks, day=days, hour=hours, minute=minutes, second=timestamp}
end

-- Short string format, given a timestruct
--
-- The short format for example:
-- Instead of "1 week, 3 day, 2 hour, 4 minute, 17 second"
-- Would be   "1w 3d 2h 4m 17s"
laston.short_str_format = function(t)
    local result = ""
    if t.week ~= 0 then
        result = result .. t.week .. "w"
    end
    if t.day ~= 0 then
        if result ~= "" then
            result = result .. " "
        end
        result = result .. t.day .. "d"
    end
    if t.hour ~= 0 then
        if result ~= "" then
            result = result .. " "
        end
        result = result .. t.hour .. "h"
    end
    if t.minute ~= 0 then
        if result ~= "" then
            result = result .. " "
        end
        result = result .. t.minute .. "m"
    end
    if t.second ~= 0 then
        if result ~= "" then
            result = result .. " "
        end
        result = result .. t.second .. "s"
    end
    return result
end

-- Given a field name and a timevalue (assuming of that field)
--
-- Returns fieldname or fieldname + s for if timevalue is greater than 1
laston.plural = function(timevalue, field_name)
    if timevalue > 1 then
        return field_name .. "s"
    end
    return field_name
end

-- String format, given a timestruct
--
-- Returns format in example: "1 week, 1 day, 1 hour, 2 minutes, 17 seconds"
laston.str_format = function(t)
    local result = ""
    if t.week ~= 0 then
        result = result .. t.week .. " " .. laston.plural(t.week, "week")
    end
    if t.day ~= 0 then
        if result ~= "" then
            result = result .. ", "
        end
        result = result .. t.day .. " " .. laston.plural(t.day, "day")
    end
    if t.hour ~= 0 then
        if result ~= "" then
            result = result .. ", "
        end
        result = result .. t.hour .. " " .. laston.plural(t.hour, "hour")
    end
    if t.minute ~= 0 then
        if result ~= "" then
            result = result .. ", "
        end
        result = result .. t.minute .. " " .. laston.plural(t.minute, "minute")
    end
    if t.second ~= 0 then
        if result ~= "" then
            result = result .. ", "
        end
        result = result .. t.second .. " " .. laston.plural(t.second, "second")
    end
    return result
end

laston.is_online = function(player_name)
    for idx, player in ipairs(minetest.get_connected_players()) do
        local pname = player:get_player_name()
        if pname == player_name then
            return true
        end
    end
    return false
end
