-- Constants
-- UnknownParabellum
-- January 17, 2021


local Constants = {
	["Pieces"] = {["PieceByName"] = {},["PieceById"] = {},},
	["Layouts"] = { --FEN format
		["Start"] = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1" ,
		["DoubleDiagPin"] = "8/2K5/3B4/8/5b2/6k1/8/8 w - - 0 1", --//For testing
		["DoublePin"] = "4k3/4r3/8/8/4R3/4K3/8/8 w - - 0 1",
	},
	["Palettes"] = {
		["Green"] = {
			["Light"] = Color3.fromRGB(238, 238, 210),
			["Dark"] = Color3.fromRGB(108, 151, 89),
			["Highlight"] = {
				["Light"] = Color3.fromRGB(249,247,110),
				["Dark"] = Color3.fromRGB(183,203,53),				
			} ,
		},
		["Ocean Blue"] = {
			["Light"] = Color3.fromRGB(235,233,210),
			["Dark"] = Color3.fromRGB(56,116,153),
			["Highlight"] = {
				["Light"] = Color3.fromRGB(75,201,234),
				["Dark"] = Color3.fromRGB(0,142,205),				
			} ,
		},
		["Brown Board"] = {
			["Light"] = Color3.fromRGB(246,216,181),
			["Dark"] = Color3.fromRGB(191,134,97),
			["Highlight"] = {
				["Light"] = Color3.fromRGB(253,235,94),
				["Dark"] = Color3.fromRGB(225,195,52),				
			} ,
		},
		["Dark Blue"] = {
			["Light"] = Color3.fromRGB(102,114,131),
			["Dark"] = Color3.fromRGB(33,42,54),
			["Highlight"] = {
				["Light"] = Color3.fromRGB(86,130,155),
				["Dark"] = Color3.fromRGB(51,95,117),				
			} ,
		},
	},
	["PieceStyles"] = {
		["Neo"] = {
			["Black"] = {
				["Queen"] = "rbxassetid://6404946187",
				["Pawn"] = "rbxassetid://6435993081",
				["Knight"] = "rbxassetid://6404946600",
				["King"] = "rbxassetid://6404946719",
				["Bishop"] = "rbxassetid://6404947079",
				["Rook"] = "rbxassetid://6435998445",
			},
			["White"] = {
				["Queen"] = "rbxassetid://6404946326",
				["Pawn"] = "rbxassetid://6435982475",
				["Knight"] = "rbxassetid://6404945828",
				["King"] = "rbxassetid://6404937018",
				["Bishop"] = "rbxassetid://6404945912",	
				["Rook"] = "rbxassetid://6435975974",
			},
		},
	},
	["SFX"] = {
		["BoardSounds"] = {
			
		},
	},
	
	["SideBarThemes"] = {
		["Default"] = {
			
		},
	},
	
	
}

local function setReadOnlyTable(table: Dictionary)
    local readOnly = setmetatable({}, {
        __index = table,
        __newindex = function(table, key, value)
            error("Attempt to modify read-only table")
        end,
        __metatable = false
    })
    for index,val in pairs(table) do
        if typeof(val) == "table" then
            rawset(readOnly, index,setReadOnlyTable(val))
        end
    end
    return readOnly
end

function Constants:AddPiece(name,value)
	local newPiece = {
		["Name"] = name,
		["Id"] = #self.Pieces.PieceById + 1,
		["Value"] = value,
	}
	self.Pieces.PieceByName[name] = newPiece
	table.insert(self.Pieces.PieceById,newPiece)
end

function Constants:Init()
	self:AddPiece("Pawn",1)
	self:AddPiece("Bishop",3)
	self:AddPiece("Knight",3)
	self:AddPiece("Rook",5)
	self:AddPiece("Queen",9)
	self:AddPiece("King",math.huge)
    Constants = setReadOnlyTable(Constants)
end


return Constants