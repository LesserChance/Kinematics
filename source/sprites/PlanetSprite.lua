import 'utilities/Utilities'

local pd <const> = playdate
local gfx <const> = pd.graphics

---@class PlanetSprite: NobleSprite
---@field super NobleSprite
PlanetSprite = {}
class("PlanetSprite", PlanetSprite).extends(NobleSprite)

function PlanetSprite:init()
    PlanetSprite.super.init(self, "assets/images/planet", true, false)

    self.shadow = playdate.graphics.image.new("assets/images/planetshadow")

    -- State Machine
    self.animation:addState("rot0", 1, 1)
    self.animation:addState("rot1", 2, 2)
    self.animation:addState("rot2", 3, 3)
    self.animation:addState("rot3", 4, 4)
    self.animation:addState("rot4", 5, 5)
    self.animation:addState("rot5", 6, 6)
    self.animation:addState("rot6", 7, 7)
    self.animation:addState("rot7", 8, 8)
    self.animation:setState(self.animation.rot0)

    -- Sprite properties
    self:setZIndex(0)
    self:setSize(64, 64)
    self:moveTo(DISPLAY_CENTER.x, DISPLAY_CENTER.y)
end

function PlanetSprite:draw(x, y)
    PlanetSprite.super.draw(self)

    -- draw the shadow
    self.shadow:draw(x, y)
end

function PlanetSprite:crankInputHandler(change, acceleratedChange)
    local crankPosition = (playdate.getCrankPosition() + 10) % 360
    local newRotation = math.floor((crankPosition) / 22.5) % 8
    local drawFlipped = crankPosition >= 180

    self.animation:setState("rot" .. newRotation)
    self.animation.direction = drawFlipped and playdate.graphics.kImageFlippedXY or playdate.graphics
        .kImageUnflipped
end
