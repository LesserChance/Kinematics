import 'sprites/PlanetSprite'
import "background"

local pd <const> = playdate
local gfx <const> = pd.graphics

---@class MainScene: NobleScene
---@field super NobleScene
MainScene = {}
class("MainScene", MainScene).extends(NobleScene)

local planet
local background
local gravity

function MainScene:init()
    MainScene.super.init(self)

    gravity = pd.geometry.vector2D.new(0, 0)
    background = Background()

    planet = PlanetSprite()
    self:addSprite(planet)

    self.inputHandler = {
        cranked = function(change, acceleratedChange)
            planet:crankInputHandler(change, acceleratedChange)
        end,
        upButtonDown = function()
            gravity.dy -= 50
            background:moveCenter(gravity)
        end,
        upButtonUp = function()
            gravity.dy += 50
            background:moveCenter(gravity)
        end,
        downButtonDown = function()
            gravity.dy += 50
            background:moveCenter(gravity)
        end,
        downButtonUp = function()
            gravity.dy -= 50
            background:moveCenter(gravity)
        end,
        leftButtonDown = function()
            gravity.dx -= 50
            background:moveCenter(gravity)
        end,
        leftButtonUp = function()
            gravity.dx += 50
            background:moveCenter(gravity)
        end,
        rightButtonDown = function()
            gravity.dx += 50
            background:moveCenter(gravity)
        end,
        rightButtonUp = function()
            gravity.dx -= 50
            background:moveCenter(gravity)
        end,
    }
end

function MainScene:enter()
    MainScene.super.enter(self)
end

function MainScene:start()
    MainScene.super.start(self)
end

function MainScene:drawBackground()
    background:draw()
end

function MainScene:update()
    MainScene.super.update(self)
end

function MainScene:exit()
    MainScene.super.exit(self)
end
