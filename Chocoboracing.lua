math.randomseed(os.time())

function random_wait(min, max)
    local r = math.random(min * 10, max * 10) / 10
    yield("/wait " .. r)
end

while true do
    local zone

    -- Wait until inside Sagolii Road (zone ID 390)
    repeat
        yield("/wait 1")
        zone = GetZoneID()
    until zone == 390

    -- Try Super Sprint until it activates (race has started)
    local sprinted = false
    repeat
        yield("/send KEY_2")
        random_wait(0.4, 0.6)   -- Slightly variable wait
        sprinted = HasStatusId(1058)
    until sprinted == true

    -- Steer left with variable hold time
    local steer_time = math.random(5, 7)
    yield("/hold A")
    yield("/wait " .. steer_time)
    yield("/release A")

    -- Wait until zone changes (race ends)
    repeat
        yield("/wait 2")
        zone = GetZoneID()
    until zone ~= 390

end