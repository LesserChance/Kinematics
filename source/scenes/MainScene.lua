import 'sprites/SpiderSprite'

MainScene = {}
class("MainScene", MainScene).extends(NobleScene)

local spider

function MainScene:setValues()

end

function MainScene:init()
    MainScene.super.init(self)

    spider = SpiderSprite(100, 100)
    self:addSprite(spider)

    self.inputHandler = {
        AButtonUp = function()
            print(spider.legCount)
            spider:wink()
        end
    }
end

function MainScene:enter()
    MainScene.super.enter(self)
end

function MainScene:start()
    MainScene.super.start(self)
end

function MainScene:drawBackground()
    MainScene.super.drawBackground(self)
end

function MainScene:update()
    MainScene.super.update(self)
end

function MainScene:exit()
    MainScene.super.exit(self)
end
