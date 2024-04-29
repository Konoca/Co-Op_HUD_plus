if not REPENTOGON then return end

CoopHUDplus.cmd_prefix = 'coopHUDplus_'

Console.RegisterCommand(
    CoopHUDplus.cmd_prefix..'reset',
    'reset Co-op HUD+ configuration',
    'reset Co-Op HUD+ configuration',
    true,
    AutocompleteType.NONE
)
