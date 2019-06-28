# minetest-toolranks
Minetest tool ranks mod

Tool gains levels for digging nodes. Higher level tools take longer to
wear out.

## Are you a mod developer?
Does one of your mods add new tools?
If so, to support this mod, check if it is loaded with
```minetest.get_modpath("toolranks")```
and then replace all after_use definitions with toolranks.new_afteruse.
Optionaly, you can also replace tools description with
```toolranks.create_description("Tool Name", 0, 1)```
and then set original_description to your tools name.
