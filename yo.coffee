# This imports all the layers for "yo" into yoLayers
yo = Framer.Importer.load "imported/yo"

block1 = yo.block1
heart = yo.heart
blocks = yo.blocks

blocks.draggable.enabled = true
blocks.draggable.speedX = 0

# the drag and release effect
retractTop = ->
  blocks.animate
    properties:
      y: 0
    curve: "spring(100,20,0)"
    duration: 0.1

block_height = block1.height
blocks.on Events.DragMove, ->
  # 337
  i = Math.floor(-blocks.y / block_height)
  if i >= 0
    block = yo["block#{i+1}"]
    text = yo["block#{i+1}text"]
    return if !text
    texty = 146 + (-block.screenFrame.y * 0.4)
    text.y = texty
#     print block.screenFrame,texty

blocks.on Events.DragEnd, ->
  # dunno how to do inertial stop. only got curve animations
#   v = blocks.draggable.calculateVelocity()
#   print v.y * 3
  if blocks.y > 0
    retractTop()

# pulse

pulse = new Animation(
  properties:
    scale: 1.2
  layer: heart
)
rpulse = pulse.reverse()
pulse.on Events.AnimationEnd, rpulse.start
rpulse.on Events.AnimationEnd, pulse.start
pulse.start()

