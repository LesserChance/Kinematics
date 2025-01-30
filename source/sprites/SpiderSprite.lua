SpiderSprite = {
    legCount = 8
}
class("SpiderSprite", SpiderSprite).extends(NobleSprite)
function SpiderSprite:init(__x, __y)
    SpiderSprite.super.init(self, "assets/images/player", true, false)

    -- State Machine
    self.animation:addState("idle", 1, 1)
    self.animation:addState("wink", 8, 19, "idle", false)
    self.animation:setState(self.animation.idle)

    -- Sprite properties
    self:setSize(32, 32)
    self:moveTo(__x, __y)
end

function SpiderSprite:wink()
    self.animation:setState(self.animation.wink)
end
