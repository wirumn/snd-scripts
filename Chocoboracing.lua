math.randomseed(os.time())

function jitter_wait(min, max)
    local imin = math.floor(min * 1000)
    local imax = math.floor(max * 1000)
    local r = math.random(imin, imax) / 1000
    yield("/wait " .. r)
end

while true do
    repeat jitter_wait(0.8, 1.2) until GetZoneID() == 390

    local attempts = 0
    repeat
        yield("/send KEY_2")
        jitter_wait(0.4, 0.6)
        attempts = attempts + 1
    until HasStatusId(1058) or attempts > 20

    local steer_time = math.random(450, 650) / 100  
    yield("/hold A")
    jitter_wait(steer_time - 0.3, steer_time + 0.3)
    yield("/release A")

    repeat jitter_wait(1.5, 2.5) until GetZoneID() ~= 390
end
