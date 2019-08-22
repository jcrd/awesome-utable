--- Table manipulation functions to complement AwesomeWM's gears.table.
--
-- @author James Reed &lt;jcrd@tuta.io&gt;
-- @copyright 2019 James Reed
-- @module utable

local gtable = require("gears.table")

local utable = {}

--- Group items in a table into lists according to the key returned by func.
--- func is given the current table value and must return the list key.
-- @param func The function.
-- @param tbl The table.
-- @return The new table.
function utable.group(func, tbl)
    local ret = {}
    for _, v in ipairs(tbl) do
        local i = func(v)
        if i then
            if not ret[i] then
                ret[i] = {}
            end
            table.insert(ret[i], v)
        end
    end
    return ret
end

--- Get a new table containing the items in tbl that pass the filter function.
-- @param func The filter function.
-- @param tbl The table.
-- @return The new table.
function utable.filter(func, tbl)
    local ret = {}
    for _, v in ipairs(tbl) do
        if func(v) then
            table.insert(ret, v)
        end
    end
    return ret
end

--- Check if table a contains table b.
-- @param a Haystack table.
-- @param b Needle table.
-- @return True if a contains b, otherwise false.
function utable.contains(a, b)
    return #utable.remove(a, b) == 0
end

--- Check if table a and table b contain the same items.
-- @param a First table.
-- @param b Second table.
-- @return True if a and b are contain the same items, otherwise false.
function utable.equal(a, b)
    return #a == #b and utable.contains(a, b)
end

--- Split a table into left and right segments.
-- @param tbl The table.
-- @param after The index after which to split.
-- @return A table containing keys "l" and "r".
function utable.split(tbl, after)
    local t = {
        l = {},
        r = {},
    }
    for i, v in ipairs(tbl) do
        if i <= after then
            table.insert(t.l, v)
        else
            table.insert(t.r, v)
        end
    end
    return t
end

--- Remove an item from a table.
-- @param tbl The table.
-- @param item The item.
-- @return The new table.
function utable.remove_item(tbl, item)
    local i = gtable.hasitem(tbl, item)
    if i then
        tbl = gtable.clone(tbl, false)
        table.remove(tbl, i)
    end
    return tbl
end

--- Remove items from table b that are found in table a.
-- @param a Table of values to be removed.
-- @param b Removal table.
-- @return The new table.
function utable.remove(a, b)
    local ret = b and gtable.clone(b, false) or {}
    local remove = {}
    for _, v in ipairs(a) do
        remove[v] = true
    end
    for i=#ret,1,-1 do
        if remove[ret[i]] then
            table.remove(ret, i)
        end
    end
    return ret
end

--- Add items in table a to table b if they are not present.
-- @param a Mixin table.
-- @param b Container table.
-- @return The new table.
function utable.add(a, b)
    local ret = b and gtable.clone(b, false) or {}
    for _, v in ipairs(a) do
        if not gtable.hasitem(ret, v) then
            table.insert(ret, v)
        end
    end
    return ret
end

--- Apply a reducer function to a table. The reducer function is given
--- two arguments: the accumulated value and the current table value. It must
--- return the new accumulated value.
-- @param func The reducer function.
-- @param tbl The table.
-- @return The final accumulated value.
function utable.reduce(func, tbl)
    local acc
    for i, v in ipairs(tbl) do
        if i == 1 then
            acc = v
        else
            acc = func(acc, v)
        end
    end
    return acc
end

return utable
