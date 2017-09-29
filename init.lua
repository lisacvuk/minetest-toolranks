local mod_storage = minetest.get_mod_storage()

toolranks = {}

toolranks.colors = {
  grey = minetest.get_color_escape_sequence("#9d9d9d"),
  green = minetest.get_color_escape_sequence("#1eff00"),
  gold = minetest.get_color_escape_sequence("#ffdf00"),
  white = minetest.get_color_escape_sequence("#ffffff")
}

function toolranks.get_tool_type(description)
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

function toolranks.create_description(name, uses, level)
  local description = name
  local tooltype    = toolranks.get_tool_type(description)

  local newdesc = toolranks.colors.green .. description .. "\n" ..
                  toolranks.colors.gold .. "Level " .. (level or 1) .. " " .. tooltype .. "\n" ..
                  toolranks.colors.grey .. "Nodes dug: " .. (uses or 0)

  return newdesc
end

function toolranks.get_level(uses)
  if uses <= 200 then
    return 1
  elseif uses < 400 then
    return 2
  elseif uses < 1000 then
    return 3
  elseif uses < 2000 then
    return 4
  elseif uses < 3200 then
    return 5
  else
    return 6
  end
end

function toolranks.new_afteruse(itemstack, user, node, digparams)
  local itemmeta  = itemstack:get_meta() -- Metadata
  local itemdef   = itemstack:get_definition() -- Item Definition
  local itemdesc  = itemdef.original_description -- Original Description
  local dugnodes  = tonumber(itemmeta:get_string("dug")) or 0 -- Number of nodes dug
  local lastlevel = tonumber(itemmeta:get_string("lastlevel")) or 1 -- Level the tool had
                                                                    -- on the last dig
  local most_digs = mod_storage:get_int("most_digs") or 0
  local most_digs_user = mod_storage:get_string("most_digs_user") or 0
  
  -- Only count nodes that spend the tool
  if(digparams.wear > 0) then
   dugnodes = dugnodes + 1
   itemmeta:set_string("dug", dugnodes)
  end
  if(dugnodes > most_digs) then
    most_digs = dugnodes
    if(most_digs_user ~= user:get_player_name()) then -- Avoid spam.
      most_digs_user = user:get_player_name()
      minetest.chat_send_all("Most used tool is now a " .. toolranks.colors.green .. itemdesc 
                             .. toolranks.colors.white .. " owned by " .. user:get_player_name()
                             .. " with " .. dugnodes .. " uses.")
    end
    mod_storage:set_int("most_digs", dugnodes)
    mod_storage:set_string("most_digs_user", user:get_player_name())
  end
  if(itemstack:get_wear() > 60135) then
    minetest.chat_send_player(user:get_player_name(), "Your tool is about to break!")
    minetest.sound_play("default_tool_breaks", {
      to_player = user:get_player_name(),
      gain = 2.0,
    })
  end
  local level = toolranks.get_level(dugnodes)

  if lastlevel < level then
    local levelup_text = "Your " .. toolranks.colors.green ..
                         itemdesc .. toolranks.colors.white ..
                         " just leveled up!"
    minetest.sound_play("toolranks_levelup", {
      to_player = user:get_player_name(),
      gain = 2.0,
    })
    minetest.chat_send_player(user:get_player_name(), levelup_text)
    itemmeta:set_string("lastlevel", level)
  end

  local newdesc   = toolranks.create_description(itemdesc, dugnodes, level)

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
  description = toolranks.create_description("Diamond Pickaxe", 0, 1),
  after_use = toolranks.new_afteruse})

minetest.override_item("default:axe_diamond", {
  original_description = "Diamond Axe",
  description = toolranks.create_description("Diamond Axe", 0, 1),
  after_use = toolranks.new_afteruse})

minetest.override_item("default:shovel_diamond", {
  original_description = "Diamond Shovel",
  description = toolranks.create_description("Diamond Shovel", 0, 1),
  after_use = toolranks.new_afteruse})

minetest.override_item("default:pick_wood", {
  original_description = "Wooden Pickaxe",
  description = toolranks.create_description("Wooden Pickaxe", 0, 1),
  after_use = toolranks.new_afteruse})

minetest.override_item("default:axe_wood", {
  original_description = "Wooden Axe",
  description = toolranks.create_description("Wooden Axe", 0, 1),
  after_use = toolranks.new_afteruse})

minetest.override_item("default:shovel_wood", {
  original_description = "Wooden Shovel",
  description = toolranks.create_description("Wooden Shovel", 0, 1),
  after_use = toolranks.new_afteruse})

minetest.override_item("default:pick_steel", {
  original_description = "Steel Pickaxe",
  description = toolranks.create_description("Steel Pickaxe", 0, 1),
  after_use = toolranks.new_afteruse})

minetest.override_item("default:axe_steel", {
  original_description = "Steel Axe",
  description = toolranks.create_description("Steel Axe", 0, 1),
  after_use = toolranks.new_afteruse})

minetest.override_item("default:shovel_steel", {
  original_description = "Steel Shovel",
  description = toolranks.create_description("Steel Shovel", 0, 1),
  after_use = toolranks.new_afteruse})

minetest.override_item("default:pick_stone", {
  original_description = "Stone Pickaxe",
  description = toolranks.create_description("Stone Pickaxe", 0, 1),
  after_use = toolranks.new_afteruse})

minetest.override_item("default:axe_stone", {
  original_description = "Stone Axe",
  description = toolranks.create_description("Stone Axe", 0, 1),
  after_use = toolranks.new_afteruse})

minetest.override_item("default:shovel_stone", {
  original_description = "Stone Shovel",
  description = toolranks.create_description("Stone Shovel", 0, 1),
  after_use = toolranks.new_afteruse})

minetest.override_item("default:pick_bronze", {
  original_description = "Bronze Pickaxe",
  description = toolranks.create_description("Bronze Pickaxe", 0, 1),
  after_use = toolranks.new_afteruse})

minetest.override_item("default:axe_bronze", {
  original_description = "Bronze Axe",
  description = toolranks.create_description("Bronze Axe", 0, 1),
  after_use = toolranks.new_afteruse})

minetest.override_item("default:shovel_bronze", {
  original_description = "Bronze Shovel",
  description = toolranks.create_description("Bronze Shovel", 0, 1),
  after_use = toolranks.new_afteruse})

minetest.override_item("default:pick_mese", {
  original_description = "Mese Pickaxe",
  description = toolranks.create_description("Mese Pickaxe", 0, 1),
  after_use = toolranks.new_afteruse})

minetest.override_item("default:axe_mese", {
  original_description = "Mese Axe",
  description = toolranks.create_description("Mese Axe", 0, 1),
  after_use = toolranks.new_afteruse})

minetest.override_item("default:shovel_mese", {
  original_description = "Mese Shovel",
  description = toolranks.create_description("Mese Shovel", 0, 1),
  after_use = toolranks.new_afteruse})

if minetest.get_modpath("moreores") then

  minetest.override_item("moreores:pick_mithril", {
    original_description = "Mithril Pickaxe",
    description = toolranks.create_description("Mithril Pickaxe", 0, 1),
    after_use = toolranks.new_afteruse})

  minetest.override_item("moreores:axe_mithril", {
    original_description = "Mithril Axe",
    description = toolranks.create_description("Mithril Axe", 0, 1),
    after_use = toolranks.new_afteruse})

  minetest.override_item("moreores:shovel_mithril", {
    original_description = "Mithril Shovel",
    description = toolranks.create_description("Mithril Shovel", 0, 1),
    after_use = toolranks.new_afteruse})

  minetest.override_item("moreores:pick_silver", {
    original_description = "Silver Pickaxe",
    description = toolranks.create_description("Silver Pickaxe", 0, 1),
    after_use = toolranks.new_afteruse})

  minetest.override_item("moreores:axe_silver", {
    original_description = "Silver Axe",
    description = toolranks.create_description("Silver Axe", 0, 1),
    after_use = toolranks.new_afteruse})

  minetest.override_item("moreores:shovel_silver", {
    original_description = "Silver Shovel",
    description = toolranks.create_description("Silver Shovel", 0, 1),
    after_use = toolranks.new_afteruse})
end
