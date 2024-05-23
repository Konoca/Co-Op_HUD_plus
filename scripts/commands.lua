if not REPENTOGON then return end

local mod = CoopHUDplus
mod.cmd_prefix = 'coopHUDplus_'

Console.RegisterCommand(
    mod.cmd_prefix..'reset',
    'reset '..mod.Name..' configuration',
    'reset '..mod.Name..' configuration',
    true,
    AutocompleteType.NONE
)
