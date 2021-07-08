function createDangerCircle(position, radius, duration)
    local pIdx = ParticleManager:CreateParticle("particles/danger_circle.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl( pIdx, 0, position ) -- vec pos
    ParticleManager:SetParticleControl( pIdx, 1, Vector( 255, 0, 0 ) ) -- vec color
    ParticleManager:SetParticleControl( pIdx, 2, Vector( 150, 0, 0 ) ) -- alpha
    ParticleManager:SetParticleControl( pIdx, 3, Vector( radius, 0, 0 ) ) -- radius
    Timers:CreateTimer(duration, function()
            ParticleManager:DestroyParticle(pIdx, false)
            return nil
        end
    )
end

function destroyParticleAfter(particleIdx, seconds, noAnimation)
    noAnimation = noAnimation or false
    Timers:CreateTimer(seconds, function()
            ParticleManager:DestroyParticle(particleIdx, noAnimation)
            return nil
        end
    )
end
