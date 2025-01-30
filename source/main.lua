import 'libraries/noble/Noble'
import 'scenes/MainScene'

Noble.Settings.setup({
})

Noble.GameData.setup({
})

Noble.showFPS = true

Noble.new(MainScene)
