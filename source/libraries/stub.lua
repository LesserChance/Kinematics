---@meta
--- This file contains function stubs for autocompletion. DO NOT include it in your game.

--- An extension of Playdate's sprite object, incorporating `Noble.Animation` and other Noble Engine features.
--- Use this in place of `playdate.graphics.sprite` in most cases.
--- `NobleSprite` is a child class of `playdate.graphics.sprite`, so see the Playdate SDK documentation for additional methods and properties.
--- @class NobleSprite : playdate.graphics.sprite
--- @field animation Noble.Animation
NobleSprite = {}
class("NobleSprite").extends(Graphics.sprite)

--- An abstract scene class.
--- Do not copy this file as a template for your scenes. Instead, your scenes will extend this class.
--- See <a href="../examples/SceneTemplate.lua.html">templates/SceneTemplate.lua</a> for a blank scene that you can copy and modify for your own scenes.
--- If you are using <a href="http://github.com/NobleRobot/NobleEngine-ProjectTemplate">NobleEngine-ProjectTemplate</a>,
--- see `scenes/ExampleScene.lua` for an implementation example.
--- @class NobleScene
--- @field name string
--- @field backgroundColor integer
--- @field inputHandler table
--- @field sprites table
NobleScene = {}

--- Animation states using a spritesheet/imagetable. Ideal for use with `NobleSprite` objects. Suitable for other uses as well.
--- @class Noble.Animation : playdate.graphics.animation
--- @field DIRECTION_RIGHT integer 0
--- @field DIRECTION_LEFT integer 1
--- @field current Noble.Animation The currently set animation state. This is intended as `read-only`. You should not modify this property directly.
--- @field currentName string The name of the current animation state. Calling this instead of `animation.current.name` is <em>just</em> a little faster. This is intended as `read-only`. You should not modify this property directly.
--- @field currentFrame integer The current frame of the animation. This is the index of the imagetable, not the frame of the current state. Most of the time, you should not modify this directly, although you can if you're feeling saucy and are prepared for unpredictable results.
--- @field direction integer This controls the flipping of the image when drawing. DIRECTION_RIGHT is unflipped, DIRECTION_LEFT is flipped on the X axis.
--- @field imageTable playdate.graphics.imagetable This animation's spritesheet. You can replace this with another `playdate.graphics.imagetable` object, but generally you would not want to.
--- @field frameDurationCount integer The current count of frame durations. This is used to determine when to advance to the next frame.
--- @field previousFrameDurationCount integer The previous number of frame durations in the animation
Noble.Animation = {}

--- Create a new animation "state machine". This function is called automatically when creating a new `NobleSprite`.
--- @string __view This can be: the path to a spritesheet image file or an image table object (`Graphics.imagetable`). See Playdate SDK docs for imagetable file naming conventions.
--- @return playdate.graphics.animation
function Noble.Animation.new(__view) end

--- Add an animation state. The first state added will be the default set for this animation.
---
--- <strong>NOTE:</strong> Added states are first-degree member objects of your Noble.Animation object, so do not use names of already existing methods/properties ("current", "draw", etc.).
--- @param __name string The name of the animation, this is also used as the key for the animation.
--- @param __startFrame integer This is the first frame of this animation in the imagetable/spritesheet
--- @param __endFrame integer This is the final frame of this animation in the imagetable/spritesheet
--- @param __next? string By default, animation states will loop, but if you want to sequence an animation, enter the name of the next state here.
--- @param __loop? boolean [opt=true] If you want a state to "freeze" on its final frame, instead of looping, enter `false` here.
--- @param __onComplete? param This function will run when this animation is complete. Be careful when using this on a looping animation!
--- @param  __frameDuration? integer [opt=1]This is the number of ticks between each frame in this animation. If not specified, it will be set to 1.
function Noble.Animation:addState(__name, __startFrame, __endFrame, __next, __loop, __onComplete, __frameDuration)
end

--- Sets the current animation state. This can be run in a object's `update` method because it only changes the animation state if the new state is different from the current one.
--- @param __animationState string|Noble.Animation The name of the animation to set. You can pass the name of the state, or the object itself.
--- @param __continuous? boolean [opt=false] Set to true if your new state's frames line up with the previous one's, i.e.: two walk cycles but one is wearing a cute hat!
--- @param __unlessThisState? string|Noble.Animation If this state is the current state, do not set the new one.
function Noble.Animation:setState(__animationState, __continuous, __unlessThisState)
end

--- Draw the current frame.
---
--- When attached to a NobleSprite, this is called by `NobleSprite:draw()` when added to a scene. For non-NobleSprite sprites, put this method inside your sprite's `draw()` method, or inside @{NobleScene:update|NobleScene:update}.
--- @param __x number [opt=0]
--- @param __y number [opt=0]
--- @param __advance boolean [opt=true] Advances to the next frame after drawing this one. Noble.Animation is frame-based, not "delta time"-based, so its speed is dependent on your game's framerate.
function Noble.Animation:draw(__x, __y, __advance)
end

--- Sometimes, you just want to draw a specific frame.
--- Use this for objects or sprites that you want to control outside of update loops, such as score counters, flipbook-style objects that respond to player input, etc.
--- @param __frameNumber integer The frame to draw from the current state. This is not an imagetable index. Entering `1` will draw the selected state's `startFrame`.
--- @param __stateName? string [opt=self.currentName] The specific state to pull the __frameNumber from.
--- @param __x? number [opt=0]
--- @param __y? number [opt=0]
--- @param __direction? integer [opt=self.direction]  Override the current direction.
function Noble.Animation:drawFrame(__frameNumber, __stateName, __x, __y, __direction)
end
