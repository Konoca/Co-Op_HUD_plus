Better_Coop_HUD.players = {}

Better_Coop_HUD.pills = {}

Better_Coop_HUD.Player = {}
Better_Coop_HUD.Player.__index = Better_Coop_HUD.Player
setmetatable(Better_Coop_HUD.Player, {
	__call = function(cls, ...)
		return cls.new(...)
	end,
})

Better_Coop_HUD.Heart = {}
Better_Coop_HUD.Heart.__index = Better_Coop_HUD.Heart
setmetatable(Better_Coop_HUD.Heart, {
	__call = function(cls, ...)
		return cls.new(...)
	end,
})

Better_Coop_HUD.Health = {}
Better_Coop_HUD.Health.__index = Better_Coop_HUD.Health
setmetatable(Better_Coop_HUD.Heart, {
	__call = function(cls, ...)
		return cls.new(...)
	end,
})

Better_Coop_HUD.Item = {}
Better_Coop_HUD.Item.__index = Better_Coop_HUD.Item
setmetatable(Better_Coop_HUD.Item, {
	__call = function(cls, ...)
		return cls.new(...)
	end,
})

Better_Coop_HUD.ActiveItem = {}
Better_Coop_HUD.ActiveItem.__index = Better_Coop_HUD.ActiveItem
setmetatable(Better_Coop_HUD.ActiveItem, {
	__call = function(cls, ...)
		return cls.new(...)
	end,
})

Better_Coop_HUD.Trinket = {}
Better_Coop_HUD.Trinket.__index = Better_Coop_HUD.Trinket
setmetatable(Better_Coop_HUD.Trinket, {
	__call = function(cls, ...)
		return cls.new(...)
	end,
})

Better_Coop_HUD.PocketItem = {}
Better_Coop_HUD.PocketItem.__index = Better_Coop_HUD.PocketItem
setmetatable(Better_Coop_HUD.PocketItem, {
	__call = function(cls, ...)
		return cls.new(...)
	end,
})

Better_Coop_HUD.PocketActiveItem = {}
Better_Coop_HUD.PocketActiveItem.__index = Better_Coop_HUD.PocketActiveItem
setmetatable(Better_Coop_HUD.PocketActiveItem, {
	__call = function(cls, ...)
		return cls.new(...)
	end,
})

Better_Coop_HUD.Pockets = {}
Better_Coop_HUD.Pockets.__index = Better_Coop_HUD.Pockets
setmetatable(Better_Coop_HUD.Pockets, {
	__call = function(cls, ...)
		return cls.new(...)
	end,
})

Better_Coop_HUD.Stat = {}
Better_Coop_HUD.Stat.__index = Better_Coop_HUD.Stat
setmetatable(Better_Coop_HUD.Stat, {
	__call = function(cls, ...)
		return cls.new(...)
	end,
})

Better_Coop_HUD.Stats = {}
Better_Coop_HUD.Stats.__index = Better_Coop_HUD.Stats
setmetatable(Better_Coop_HUD.Stats, {
	__call = function(cls, ...)
		return cls.new(...)
	end,
})

Better_Coop_HUD.Misc = {}
Better_Coop_HUD.Misc.__index = Better_Coop_HUD.Misc
setmetatable(Better_Coop_HUD.Misc, {
	__call = function(cls, ...)
		return cls.new(...)
	end,
})

Better_Coop_HUD.Miscs = {}
Better_Coop_HUD.Miscs.__index = Better_Coop_HUD.Miscs
setmetatable(Better_Coop_HUD.Misc, {
	__call = function(cls, ...)
		return cls.new(...)
	end,
})
