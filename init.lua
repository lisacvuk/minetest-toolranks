local mod_storage = minetest.get_mod_storage()
local S = minetest.get_translator("toolranks")

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
  else
    local d = string.lower(description)
    if string.find(d, "pickaxe") then
      return "pickaxe"
    elseif string.find(d, "axe") then
      return "axe"
    elseif string.find(d, "shovel") then
      return "shovel"
    elseif string.find(d, "hoe") then
      return "hoe"
    elseif string.find(d, "sword") then
      return "sword"
    else
      return "tool"
    end
  end
end

function toolranks.create_description(name, uses, level)
  local description = name
  local tooltype    = toolranks.get_tool_type(description)

  local newdesc = S("@1@2\n@3Level @4 @5\n@6@Node dug: @7", 
                    toolranks.colors.green,
                    description,
                    toolranks.colors.gold,
                    (level or 1),
                    S(tooltype),
                    toolranks.colors.grey,
                    (uses or 0))
  return newdesc
end

function toolranks.get_level(uses)
  return math.min(100, math.floor(uses / 1000))
end

function toolranks.new_afteruse(itemstack, user, node, digparams)
  local itemmeta  = itemstack:get_meta() -- Metadata
  local itemdef   = itemstack:get_definition() -- Item Definition
  local itemdesc  = itemdef.original_description -- Original Description
  local dugnodes  = tonumber(itemmeta:get_string("dug")) or 0 -- Number of nodes dug
  local lastlevel = tonumber(itemmeta:get_string("lastlevel")) or 0 -- Level the tool had
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
      minetest.chat_send_all(S("Most used tool is now a @1@2@3 owned by @4 with @5 uses.",
                               toolranks.colors.green,
                               itemdesc,
                               toolranks.colors.white,
                               user:get_player_name(),
                               dugnodes))
    end
    mod_storage:set_int("most_digs", dugnodes)
    mod_storage:set_string("most_digs_user", user:get_player_name())
  end
  if(itemstack:get_wear() > 60135) then
    minetest.chat_send_player(user:get_player_name(), S("Your tool is about to break!"))
    minetest.sound_play("default_tool_breaks", {
      to_player = user:get_player_name(),
      gain = 2.0,
    })
  end
  local level = toolranks.get_level(dugnodes)

  if lastlevel < level then
    local levelup_text = S("Your @1@2@3 just leveled up!",
                           toolranks.colors.green,
                           itemdesc,
                           toolranks.colors.white)
    minetest.sound_play("toolranks_levelup", {
      to_player = user:get_player_name(),
      gain = 2.0,
    })
    minetest.chat_send_player(user:get_player_name(), levelup_text)
    itemmeta:set_string("lastlevel", level)
	local speed_multi = 1 - (level * 0.005)
	local use_multi = 1 + (level * 0.01)
	local caps = table.copy(itemdef.tool_capabilities)
	caps.full_punch_interval = caps.full_punch_interval and (caps.full_punch_interval * speed_multi)
	caps.punch_attack_uses = caps.punch_attack_uses and (caps.punch_attack_uses * use_multi)
	for _,c in pairs(caps.groupcaps) do
		c.uses = c.uses * use_multi
		for i,t in ipairs(c.times) do
			c.times[i] = t * speed_multi
		end
	end	
	itemmeta:set_tool_capabilities(caps)
  end
  itemmeta:set_string("description", toolranks.create_description(itemdesc, dugnodes, level))
  itemstack:add_wear(digparams.wear)
  return itemstack
end

-- Helper function
local function add_tool(name)
  local desc = ItemStack(name):get_definition().description
  minetest.override_item(name, {
          original_description = desc,
          description = toolranks.create_description(desc, 0, 1),
          after_use = toolranks.new_afteruse
  })
end

-- Sword
add_tool("default:sword_wood")
add_tool("default:sword_stone")
add_tool("default:sword_steel")
add_tool("default:sword_bronze")
add_tool("default:sword_mese")
add_tool("default:sword_diamond")

-- Pickaxe
add_tool("default:pick_wood")
add_tool("default:pick_stone")
add_tool("default:pick_steel")
add_tool("default:pick_bronze")
add_tool("default:pick_mese")
add_tool("default:pick_diamond")

-- Axe
add_tool("default:axe_wood")
add_tool("default:axe_stone")
add_tool("default:axe_steel")
add_tool("default:axe_bronze")
add_tool("default:axe_mese")
add_tool("default:axe_diamond")

-- Shovel
add_tool("default:shovel_wood")
add_tool("default:shovel_stone")
add_tool("default:shovel_steel")
add_tool("default:shovel_bronze")
add_tool("default:shovel_mese")
add_tool("default:shovel_diamond")
