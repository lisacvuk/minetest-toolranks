local colors = {
  grey = minetest.get_color_escape_sequence("#9d9d9d"),
  green = minetest.get_color_escape_sequence("#1eff00"),
  gold = minetest.get_color_escape_sequence("#ffdf00"),
  white = minetest.get_color_escape_sequence("#ffffff")
}

function get_tool_type(description)
  if string.find(description, "Pickaxe") then
    return "pickaxe"
  elseif string.find(description, "Axe") then
    return "axe"
  elseif string.find(description, "Shovel") then
    return "shovel"
  elseif string.find(description, "Hoe") then
    return "hoe"
  else
    return "tool"
  end
end

function create_description(name, uses, level)
  local description = name
  local tooltype    = get_tool_type(description)

  local newdesc = colors.green .. description .. "\n" ..
                  colors.gold .. "Level " .. level .. " " .. tooltype .. "\n" ..
                  colors.grey .. "Nodes dug: " .. uses

  return newdesc
end

function get_level(uses)
  if uses <= 100 then
    return 1
  elseif uses < 200 then
    return 2
  elseif uses < 400 then
    return 3
  elseif uses < 800 then
    return 4
  elseif uses < 1600 then
    return 5
  else
    return 6
  end
end

function new_afteruse(itemstack, user, node, digparams)
  local itemmeta  = itemstack:get_meta() -- Metadata
  local itemdef   = itemstack:get_definition() -- Item Definition
  local itemdesc  = itemdef.original_description -- Original Description
  local dugnodes  = tonumber(itemmeta:get_string("dug")) or 0 -- Number of nodes dug
  local lastlevel = tonumber(itemmeta:get_string("lastlevel")) or 1 -- Level the tool had
                                                                    -- on the last dig

  dugnodes = dugnodes + 1

  level = get_level(dugnodes)

  if lastlevel < level then
    local levelup_text = "Your " .. colors.green ..
                         itemdesc .. colors.white ..
                         " just leveled up!"
    minetest.chat_send_player(user:get_player_name(), levelup_text)
  end

  local newdesc   = create_description(itemdesc, dugnodes, level)

  itemmeta:set_string("lastlevel", level)
  itemmeta:set_string("dug", dugnodes)
  itemmeta:set_string("description", newdesc)
  local wear = digparams.wear
  if level > 1 then
    wear = digparams.wear / (1 + level / 4)
  end

  --minetest.chat_send_all("wear="..wear.."Original wear: "..digparams.wear.." 1+level/4="..1+level/4)
  -- Uncomment for testing ^

  itemstack:add_wear(wear)

  return itemstack
end

minetest.override_item("default:pick_diamond", {
  original_description = "Diamond Pickaxe",
  description = create_description("Diamond Pickaxe", 0, 1),
  after_use = new_afteruse,
})
minetest.override_item("default:axe_diamond", {
  original_description = "Diamond Axe",
  description = create_description("Diamond Axe", 0, 1),
  after_use = new_afteruse,
})
minetest.override_item("default:shovel_diamond", {
  original_description = "Diamond Shovel",
  description = create_description("Diamond Shovel", 0, 1),
  after_use = new_afteruse,
})
minetest.override_item("default:pick_wood", {
  original_description = "Wooden Pickaxe",
  description = create_description("Wooden Pickaxe", 0, 1),
  after_use = new_afteruse,
})
minetest.override_item("default:axe_wood", {
  original_description = "Wooden Axe",
  description = create_description("Wooden Axe", 0, 1),
  after_use = new_afteruse,
})
minetest.override_item("default:shovel_wood", {
  original_description = "Wooden Shovel",
  description = create_description("Wooden Shovel", 0, 1),
  after_use = new_afteruse,
})
minetest.override_item("default:pick_steel", {
  original_description = "Steel Pickaxe",
  description = create_description("Steel Pickaxe", 0, 1),
  after_use = new_afteruse,
})
minetest.override_item("default:axe_steel", {
  original_description = "Steel Axe",
  description = create_description("Steel Axe", 0, 1),
  after_use = new_afteruse,
})
minetest.override_item("default:shovel_steel", {
  original_description = "Steel Shovel",
  description = create_description("Steel Shovel", 0, 1),
  after_use = new_afteruse,
})
minetest.override_item("default:pick_stone", {
  original_description = "Stone Pickaxe",
  description = create_description("Stone Pickaxe", 0, 1),
  after_use = new_afteruse,
})
minetest.override_item("default:axe_stone", {
  original_description = "Stone Axe",
  description = create_description("Stone Axe", 0, 1),
  after_use = new_afteruse,
})
minetest.override_item("default:shovel_stone", {
  original_description = "Stone Shovel",
  description = create_description("Stone Shovel", 0, 1),
  after_use = new_afteruse,
})
minetest.override_item("default:pick_bronze", {
  original_description = "Bronze Pickaxe",
  description = create_description("Bronze Pickaxe", 0, 1),
  after_use = new_afteruse,
})
minetest.override_item("default:axe_bronze", {
  original_description = "Bronze Axe",
  description = create_description("Bronze Axe", 0, 1),
  after_use = new_afteruse,
})
minetest.override_item("default:shovel_bronze", {
  original_description = "Bronze Shovel",
  description = create_description("Bronze Shovel", 0, 1),
  after_use = new_afteruse,
})
minetest.override_item("default:pick_mese", {
  original_description = "Mese Pickaxe",
  description = create_description("Mese Pickaxe", 0, 1),
  after_use = new_afteruse,
})
minetest.override_item("default:axe_mese", {
  original_description = "Mese Axe",
  description = create_description("Mese Axe", 0, 1),
  after_use = new_afteruse,
})
minetest.override_item("default:shovel_mese", {
  original_description = "Mese Shovel",
  description = create_description("Mese Shovel", 0, 1),
  after_use = new_afteruse,
})
