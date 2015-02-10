local _,_,_,tab,_ = unpack(require(arc_path .. 'code'))
local draw = require(arc_path .. 'draw')

-- shortcuts
local lg = love.graphics
local lk = love.keyboard

-- key class
local _key = {}
_key.__index = _key
function _key:new(btn)
    local o = {}
    setmetatable(o,_key)
    o.btn = btn
    o.t = 0
    o.pos = 0
    o.hit = false
    return o
end

function _key:check(dt)
    local z = self.pos
    self.t = self.t+dt
    if (z==0 and arc.btn.kp==self.btn) or (z==1 and lk.isDown(self.btn) and self.t>arc.cfg.key_wait0) then
        self.pos = self.pos+1
        self.t = 0
        self.hit = true
        return
    end
    if z == 2 and lk.isDown(self.btn) and self.t>arc.cfg.key_wait then
        self.t = self.t-arc.cfg.key_wait
        self.hit = true
        return
    end
    if not lk.isDown(self.btn) then self.pos = 0 end
    self.hit = false
end

return {_key}
