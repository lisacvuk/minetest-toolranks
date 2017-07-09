local ranks = {
  new = "Factory new",
  used = "A bit used",
  used_lot = "Used a lot",
  almost_spent = "Almost spent",
  spent = "Completely spent"
}
local colors = {
  grey = minetest.get_color_escape_sequence("#9d9d9d"),
  green = minetest.get_color_escape_sequence("#1eff00")
}

function get_rank(uses)
  if uses <= 10 then
    return ranks.new
  elseif uses < 50 then
    return ranks.used
  elseif uses < 150 then
    return ranks.used_lot
  elseif uses < 500 then
    return ranks.almost_spent
  elseif uses > 1000 then
    return ranks.spent
  end
end

function new_afteruse(itemstack, user, node, digparams)
  local itemmeta  = itemstack:get_meta() -- Metadata
  local itemdef   = itemstack:get_definition() -- Item Definition
  local itemdesc  = itemdef.description:lower() -- Original Description
  local dugnodes  = tonumber(itemmeta:get_string("dug")) or 0 -- Number of nodes dug

  dugnodes = dugnodes + 1

  rank = get_rank(dugnodes)

  local newdesc   = colors.green .. rank .. " " .. itemdesc .. "\n" ..
                    colors.grey .. "Nodes dug: " .. dugnodes

  itemmeta:set_string("dug", dugnodes)
  itemmeta:set_string("description", newdesc)

  return itemstack
end

minetest.override_item("default:pick_diamond", {
  after_use = new_afteruse,
})
