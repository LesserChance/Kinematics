import "CoreLibs/math"
import "CoreLibs/easing"
import "CoreLibs/graphics"
import "CoreLibs/sprites"

import 'utilities/Utilities'

local pd <const> = playdate
local gfx <const> = pd.graphics

GRAVITY_LERP_DURATION = 350

STAR_STEPS = 20
STAR_SPEED = 20

STAR_SPAWN_TIME_MIN = 20
STAR_SPAWN_TIME_MAX = 50

STAR_START_POSITION_MIN = 40
STAR_START_POSITION_MAX = 220

STAR_CURVE = 1

CIRCLE_SPEED = 100

---@class Background
Background = {
    drawAt = pd.geometry.point.new(DISPLAY_WIDTH / 2, DISPLAY_HEIGHT / 2),

    offsetX = 0,
    offsetY = 0,
    gravityXLerpTimer = nil,
    gravityYLerpTimer = nil,

    -- starArcs = {},
    -- starArcTimer = nil,
    -- starSpawnTimer = nil,
    -- starfieldImage = nil,

    opacity = .1,
    circleShrinkTimer = nil,
}

class("Background", Background).extends()

function Background:init()
    -- self.starArcTimer = playdate.timer.new(STAR_SPEED, function() self:stepStars() end)
    self.circleShrinkTimer = playdate.timer.new(CIRCLE_SPEED, function() self:stepCircles() end)

    -- self:spawnStar()
end

-- function Background:drawStars()
--     gfx.pushContext()
--     gfx.setColor(gfx.kColorXOR)

--     for i, star in ipairs(self.starArcs) do
--         local endPoint = playdate.geometry.point.new(
--             self.center100.x + (20 * math.cos(star.angle)),
--             self.center100.y + (20 * math.sin(star.angle)))

--         local midPoint = playdate.geometry.point.new(
--             self.center80.x + (40 * math.cos(star.angle + star.curve)),
--             self.center80.y + (40 * math.sin(star.angle + star.curve)))

--         local startPoint = playdate.geometry.point.new(
--             self.center30.x + (star.start * math.cos(star.angle)),
--             self.center30.y + (star.start * math.sin(star.angle)))

--         self:drawStar(
--             startPoint.x, startPoint.y,
--             midPoint.x, midPoint.y,
--             endPoint.x, endPoint.y,
--             STAR_STEPS,
--             star.step
--         )
--     end
--     gfx.popContext()
-- end

function Background:drawCircles()
    gfx.pushContext()
    gfx.setLineWidth(1)
    gfx.setColor(gfx.kColorBlack)

    gfx.setDitherPattern(0.2 - self.opacity, gfx.image.kDitherTypeBayer8x8)
    gfx.fillCircleAtPoint(self.center100, 5 + 15 * (1 - self.opacity * 10))

    gfx.setDitherPattern(0.3 - self.opacity, gfx.image.kDitherTypeBayer8x8)
    gfx.fillCircleAtPoint(self.center100, 20 + 10 * (1 - self.opacity * 10))

    gfx.setDitherPattern(0.4 - self.opacity, gfx.image.kDitherTypeBayer8x8)
    gfx.fillCircleAtPoint(self.center90, 30 + 10 * (1 - self.opacity * 10))

    gfx.setDitherPattern(0.5 - self.opacity, gfx.image.kDitherTypeBayer8x8)
    gfx.fillCircleAtPoint(self.center80, 40 + 10 * (1 - self.opacity * 10))

    gfx.setDitherPattern(0.6 - self.opacity, gfx.image.kDitherTypeBayer8x8)
    gfx.fillCircleAtPoint(self.center70, 50 + 30 * (1 - self.opacity * 10))

    gfx.setDitherPattern(0.7 - self.opacity, gfx.image.kDitherTypeBayer8x8)
    gfx.fillCircleAtPoint(self.center60, 80 + 40 * (1 - self.opacity * 10))

    gfx.setDitherPattern(0.8 - self.opacity, gfx.image.kDitherTypeBayer8x8)
    gfx.fillCircleAtPoint(self.center50, 120 + 80 * (1 - self.opacity * 10))

    gfx.setDitherPattern(0.9 - self.opacity, gfx.image.kDitherTypeBayer8x8)
    gfx.fillCircleAtPoint(self.center30, 200 + 80 * (1 - self.opacity * 10))
    gfx.popContext()
end

---comment
---@param gravity playdate.geometry.vector2D
function Background:moveCenter(gravity)
    local endX = gravity.dx
    local endY = gravity.dy

    self.gravityXLerpTimer = pd.timer.new(GRAVITY_LERP_DURATION, self.offsetX, endX, pd.easingFunctions.outQuad)
    self.gravityYLerpTimer = pd.timer.new(GRAVITY_LERP_DURATION, self.offsetY, endY, pd.easingFunctions.outQuad)
end

function Background:draw()
    if (self.gravityXLerpTimer and self.gravityXLerpTimer.running) then
        self.offsetX = self.gravityXLerpTimer.value
        self.offsetY = self.gravityYLerpTimer.value
    end

    -- points and how affected they are by gravity
    self.center100 = playdate.geometry.point.new(self.drawAt.x + (self.offsetX), self.drawAt.y + (self.offsetY))
    self.center90 = playdate.geometry.point.new(self.drawAt.x + (self.offsetX * .9), self.drawAt.y + (self.offsetY * .9))
    self.center80 = playdate.geometry.point.new(self.drawAt.x + (self.offsetX * .8), self.drawAt.y + (self.offsetY * .8))
    self.center70 = playdate.geometry.point.new(self.drawAt.x + (self.offsetX * .7), self.drawAt.y + (self.offsetY * .7))
    self.center60 = playdate.geometry.point.new(self.drawAt.x + (self.offsetX * .6), self.drawAt.y + (self.offsetY * .6))
    self.center50 = playdate.geometry.point.new(self.drawAt.x + (self.offsetX * .5), self.drawAt.y + (self.offsetY * .5))
    self.center30 = playdate.geometry.point.new(self.drawAt.x + (self.offsetX * .3), self.drawAt.y + (self.offsetY * .3))


    -- draw the stars
    -- self:drawStars()

    -- draw the concentric circles
    self:drawCircles()
end

-- function Background:stepStars()
--     for i, star in ipairs(self.starArcs) do
--         star.step = star.step + 1
--         if (star.step > STAR_STEPS) then
--             table.remove(self.starArcs, i)
--         end
--     end
--     self.starArcTimer = playdate.timer.new(STAR_SPEED, function() self:stepStars() end)
-- end

function Background:stepCircles()
    self.opacity = self.opacity - .01
    if (self.opacity < 0) then
        self.opacity = .1
    end

    self.circleShrinkTimer = playdate.timer.new(CIRCLE_SPEED, function() self:stepCircles() end)
end

-- function Background:spawnStar()
--     table.insert(self.starArcs, {
--         angle = math.random(0, 359),
--         curve = math.random(-STAR_CURVE, STAR_CURVE),
--         start = math.random(STAR_START_POSITION_MIN, STAR_START_POSITION_MAX),
--         step = 1,
--     })

--     self.starSpawnTimer = playdate.timer.new(math.random(STAR_SPAWN_TIME_MIN, STAR_SPAWN_TIME_MAX),
--         function() self:spawnStar() end)
-- end

-- function Background:drawStar(x1, y1, x2, y2, x3, y3, steps, drawSegment)
--     local d = 1 / steps
--     local prevX = x1
--     local prevY = y1
--     local x, y
--     local i = 1

--     for t = d, 1, d do
--         x = (1 - t) ^ 2 * x1 + 2 * (1 - t) * t * x2 + t ^ 2 * x3
--         y = (1 - t) ^ 2 * y1 + 2 * (1 - t) * t * y2 + t ^ 2 * y3
--         if (i == drawSegment - 1) then
--             gfx.setLineWidth(1)
--             playdate.graphics.drawLine(prevX, prevY, x, y)
--         end
--         if (i == drawSegment) then
--             gfx.setLineWidth(STAR_STEPS / i)
--             gfx.fillCircleAtPoint(x, y, STAR_STEPS / i)
--             playdate.graphics.drawLine(prevX, prevY, x, y)
--         end
--         prevX = x
--         prevY = y
--         i = i + 1
--     end
-- end
