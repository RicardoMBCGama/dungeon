-- deep clone table
utils = {}

function utils.copy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[utils.copy(orig_key)] = utils.copy(orig_value)
        end
        setmetatable(copy, utils.copy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

-- TODO: create filter function to filter enemies, objects, etc
-- function utils.filter(func, tbl)
--      local newtbl= {}
--      for i,v in pairs(tbl) do
--          if func(v) then
-- 	     newtbl[i]=v
--          end
--      end
--      return newtbl
--  end

-- TODO: test camera lerp
function utils.lerp(a, b, t)
  return a + (b - a) * t
end
