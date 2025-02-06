import "CoreLibs/math"

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
    self.damageMask = playdate.graphics.image.new(PLANET_DIAMETER, PLANET_DIAMETER)

    self.rotation = 0
    self.damagedBits = {}
    table.insert(self.damagedBits, { point = 0, depth = 0, size = 10 })
    table.insert(self.damagedBits, { point = 45, depth = 20, size = 5 })
    table.insert(self.damagedBits, { point = 40, depth = 15, size = 5 })
    self:updateDamageMask()

    -- State Machine
    self.animation:addState("rot0", 1, 1)
    self.animation:addState("rot1", 2, 2)
    self.animation:addState("rot2", 3, 3)
    self.animation:addState("rot3", 4, 4)
    self.animation:addState("rot4", 5, 5)
    self.animation:addState("rot5", 6, 6)
    self.animation:addState("rot6", 7, 7)
    self.animation:addState("rot7", 8, 8, nil, false)
    self.animation:setState("rot0")

    -- Sprite properties
    self:setZIndex(0)
    self:setSize(PLANET_DIAMETER, PLANET_DIAMETER)
    self:moveTo(DISPLAY_CENTER.x, DISPLAY_CENTER.y)

    self:setRotation(0, false)
    self.animation:setState(self.animation.rot0)
end

function PlanetSprite:draw(x, y)
    self:updateDamageMask()
    self.animation:draw(nil, nil, false)

    -- draw the shadow
    self.shadow:draw(x, y)
    self:markDirty()
end

function PlanetSprite:updateDamageMask()
    gfx.pushContext(self.damageMask)
    gfx.setColor(playdate.graphics.kColorBlack)
    gfx.fillRect(0, 0, PLANET_DIAMETER, PLANET_DIAMETER)

    gfx.setColor(playdate.graphics.kColorWhite)
    gfx.fillCircleInRect(0, 0, PLANET_DIAMETER, PLANET_DIAMETER)

    -- damaged bits
    for i, damagedBit in ipairs(self.damagedBits) do
        -- get a point on the circumference
        local damagePoint = self:getDamagedPoint(damagedBit.depth, damagedBit.point)
        gfx.setColor(playdate.graphics.kColorBlack)
        gfx.fillCircleAtPoint(damagePoint, damagedBit.size)
    end
    gfx.popContext()
end

function PlanetSprite:crankInputHandler(change, acceleratedChange)
    local crankPosition = (playdate.getCrankPosition() + 10) % 360
    local newRotation = math.floor((crankPosition) / 22.5) % 8
    local drawFlipped = crankPosition >= 180

    self:setRotation(newRotation, drawFlipped)
end

function PlanetSprite:setRotation(rotationIndex, drawFlipped)
    self.rotation = (rotationIndex * 22.5)
    self.animation:setState("rot" .. rotationIndex, false)
    self.animation.direction = drawFlipped and playdate.graphics.kImageFlippedXY or playdate.graphics
        .kImageUnflipped
    self.animation.imageTable:getImage(self.animation.currentFrame):setMaskImage(self.damageMask)
end

function PlanetSprite:getDamagedPoint(depth, point)
    local planetRadius = PLANET_DIAMETER / 2
    local damageAngle  = point + self.rotation
    local damageRadius = planetRadius - depth
    local x            = (damageRadius * math.cos(damageAngle * math.pi / 180)) + planetRadius;
    local y            = (damageRadius * math.sin(damageAngle * math.pi / 180)) + planetRadius;

    return pd.geometry.point.new(x, y)
end
