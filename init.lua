local mod_storage = minetest.get_mod_storage()

toolranks = {}

toolranks.colors = {
  grey = minetest.get_color_escape_sequence("#9d9d9d"),
  green = minetest.get_color_escape_sequence("#1eff00"),
  gold = minetest.get_color_escape_sequence("#ffdf00"),
  white = minetest.get_color_escape_sequence("#ffffff")
}

function toolranks.get_tool_type(description)
  if not description then
    return "tool"
  elseif string.find(description, "Pickaxe") then
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

-- Helper function
local function add_tool(name, desc, afteruse)

	minetest.override_item(name, {
		original_description = desc,
		description = toolranks.create_description(desc, 0, 1),
		after_use = toolranks.new_afteruse
	})
end

-- Sword
add_tool("default:sword_wood",		"Wooden Sword")
add_tool("default:sword_stone",		"Stone Sword")
add_tool("default:sword_steel",		"Steel Sword")
add_tool("default:sword_bronze",	"Bronze Sword")
add_tool("default:sword_mese",		"Mese Sword")
add_tool("default:sword_diamond",	"Diamond Sword")

-- Pickaxe
add_tool("default:pick_wood",		"Wooden Pickaxe")
add_tool("default:pick_stone",		"Stone Pickaxe")
add_tool("default:pick_steel",		"Steel Pickaxe")
add_tool("default:pick_bronze",		"Bronze Pickaxe")
add_tool("default:pick_mese",		"Mese Pickaxe")
add_tool("default:pick_diamond",	"Diamond Pickaxe")

-- Axe
add_tool("default:axe_wood",		"Wooden Axe")
add_tool("default:axe_stone",		"Stone Axe")
add_tool("default:axe_steel",		"Steel Axe")
add_tool("default:axe_bronze",		"Bronze Axe")
add_tool("default:axe_mese",		"Mese Axe")
add_tool("default:axe_diamond",		"Diamond Axe")

-- Shovel
add_tool("default:shovel_wood",		"Wooden Shovel")
add_tool("default:shovel_stone",	"Stone Shovel")
add_tool("default:shovel_steel",	"Steel Shovel")
add_tool("default:shovel_bronze",	"Bronze Shovel")
add_tool("default:shovel_mese",		"Mese Shovel")
add_tool("default:shovel_diamond",	"Diamond Shovel")
