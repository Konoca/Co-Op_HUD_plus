CoopHUDplus.players = {}
CoopHUDplus.joining = {}
CoopHUDplus.pills = {}
CoopHUDplus.SAVED_PLAYER_DATA = {}

CoopHUDplus.Player = {}
CoopHUDplus.Player.__index = CoopHUDplus.Player
setmetatable(CoopHUDplus.Player, {
	__call = function(cls, ...)
		return cls.new(...)
	end,
})

CoopHUDplus.Heart = {}
CoopHUDplus.Heart.__index = CoopHUDplus.Heart
setmetatable(CoopHUDplus.Heart, {
	__call = function(cls, ...)
		return cls.new(...)
	end,
})

CoopHUDplus.Health = {}
CoopHUDplus.Health.__index = CoopHUDplus.Health
setmetatable(CoopHUDplus.Heart, {
	__call = function(cls, ...)
		return cls.new(...)
	end,
})

CoopHUDplus.Item = {}
CoopHUDplus.Item.__index = CoopHUDplus.Item
setmetatable(CoopHUDplus.Item, {
	__call = function(cls, ...)
		return cls.new(...)
	end,
})

CoopHUDplus.ActiveItem = {}
CoopHUDplus.ActiveItem.__index = CoopHUDplus.ActiveItem
setmetatable(CoopHUDplus.ActiveItem, {
	__call = function(cls, ...)
		return cls.new(...)
	end,
})

CoopHUDplus.Trinket = {}
CoopHUDplus.Trinket.__index = CoopHUDplus.Trinket
setmetatable(CoopHUDplus.Trinket, {
	__call = function(cls, ...)
		return cls.new(...)
	end,
})

CoopHUDplus.PocketItem = {}
CoopHUDplus.PocketItem.__index = CoopHUDplus.PocketItem
setmetatable(CoopHUDplus.PocketItem, {
	__call = function(cls, ...)
		return cls.new(...)
	end,
})

CoopHUDplus.PocketActiveItem = {}
CoopHUDplus.PocketActiveItem.__index = CoopHUDplus.PocketActiveItem
setmetatable(CoopHUDplus.PocketActiveItem, {
	__call = function(cls, ...)
		return cls.new(...)
	end,
})

CoopHUDplus.Pockets = {}
CoopHUDplus.Pockets.__index = CoopHUDplus.Pockets
setmetatable(CoopHUDplus.Pockets, {
	__call = function(cls, ...)
		return cls.new(...)
	end,
})

CoopHUDplus.Stat = {}
CoopHUDplus.Stat.__index = CoopHUDplus.Stat
setmetatable(CoopHUDplus.Stat, {
	__call = function(cls, ...)
		return cls.new(...)
	end,
})

CoopHUDplus.Stats = {}
CoopHUDplus.Stats.__index = CoopHUDplus.Stats
setmetatable(CoopHUDplus.Stats, {
	__call = function(cls, ...)
		return cls.new(...)
	end,
})

CoopHUDplus.Misc = {}
CoopHUDplus.Misc.__index = CoopHUDplus.Misc
setmetatable(CoopHUDplus.Misc, {
	__call = function(cls, ...)
		return cls.new(...)
	end,
})

CoopHUDplus.Miscs = {}
CoopHUDplus.Miscs.__index = CoopHUDplus.Miscs
setmetatable(CoopHUDplus.Misc, {
	__call = function(cls, ...)
		return cls.new(...)
	end,
})

CoopHUDplus.Inventory = {}
CoopHUDplus.Inventory.__index = CoopHUDplus.Inventory
setmetatable(CoopHUDplus.Inventory, {
	__call = function(cls, ...)
		return cls.new(...)
	end,
})
