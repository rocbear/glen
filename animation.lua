return function(duration, quads)
    local animation = {quads = quads, duration = duration or 1, currentTime = 0}
    function animation.update(dt)
        animation.currentTime = animation.currentTime + dt
        if animation.currentTime >= animation.duration then
            animation.currentTime = animation.currentTime - animation.duration
        end
    end
    function animation.getQuad()
        local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
        return animation.quads[spriteNum]
    end
    return animation
end
