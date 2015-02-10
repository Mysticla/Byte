-- shortcuts
local lg = love.graphics

-- bundled draw functions
local draw = {}

-- draw text
function draw.text(s,x,y,c)
    local c = c or arc.col.white
    if arc.cfg.msg_txt_shdw then
        lg.setColor(arc.col.shadow)
        lg.print(s,x+1,y+1)
    end
    lg.setColor(c)
    lg.print(s,x,y)
end

return draw