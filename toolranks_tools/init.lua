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

  minetest.override_item("moreores:sword_mithril", {
    original_description = "Mithril Sword",
    description = toolranks.create_description("Mithril Sword", 0, 1),
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

  minetest.override_item("moreores:sword_silver", {
    original_description = "Silver Sword",
    description = toolranks.create_description("Silver Sword", 0, 1),
    after_use = toolranks.new_afteruse})
end

-- add swords for snappy nodes
minetest.override_item("default:sword_wood", {
	original_description = "Wooden Sword",
	description = toolranks.create_description("Wooden Sword", 0, 1),
	after_use = toolranks.new_afteruse})

minetest.override_item("default:sword_stone", {
	original_description = "Stone Sword",
	description = toolranks.create_description("Stone Sword", 0, 1),
	after_use = toolranks.new_afteruse})

minetest.override_item("default:sword_steel", {
	original_description = "Steel Sword",
	description = toolranks.create_description("Steel Sword", 0, 1),
	after_use = toolranks.new_afteruse})

minetest.override_item("default:sword_bronze", {
	original_description = "Bronze Sword",
	description = toolranks.create_description("Bronze Sword", 0, 1),
	after_use = toolranks.new_afteruse})

minetest.override_item("default:sword_mese", {
	original_description = "Mese Sword",
	description = toolranks.create_description("Mese Sword", 0, 1),
	after_use = toolranks.new_afteruse})

minetest.override_item("default:sword_diamond", {
	original_description = "Diamond Sword",
	description = toolranks.create_description("Diamond Sword", 0, 1),
	after_use = toolranks.new_afteruse})

