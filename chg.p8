pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
--control hell game
--by jerboas

--ideas
------
--*zelda-like graphics
--*each level has different
--control scheme
--*goal is to move player to
--target avoiding traps and
--obstacles

--todo
------
--mirror controls
--show control map on screen
--add collision detection
--make playable single level
--change player to 16x8 px

-->8
--init
function _init()
	--controls map
	ctrls={
		l=⬅️,
		r=➡️,
		u=⬆️,
		d=⬇️,
	}
	--player sprite
	pspr=1
	--player position
	ppos={x=60,y=60}
	
	--target sprite
	tspr=3
	--target position
	tpos={}
	tpos.x=ppos.x
	tpos.x+=rnd_sign()*rnd_int(25,60)
	tpos.y=ppos.y
	tpos.y+=rnd_sign()*rnd_int(25,60)
	rot=flr(rnd(3))
	if rot>0 then
		for i=1,rot do
			ctrls=rotate_ctrls_cws()
		end
	end
end

-->8
--update
function _update()
	if btn(ctrls.l) then
		ppos.x-=1
	end
	if btn(ctrls.r) then
		ppos.x+=1
	end
	if btn(ctrls.u) then
		ppos.y-=1
	end
	if btn(ctrls.d) then
		ppos.y+=1
	end
end

--rotate controls clockwise
function rotate_ctrls_cws()
	local temp_ctrls={}
	
	temp_ctrls.l=ctrls.d
	temp_ctrls.r=ctrls.u
	temp_ctrls.u=ctrls.l
	temp_ctrls.d=ctrls.r

	return temp_ctrls
end
-->8
--draw
function _draw()
	cls()
	
	--draw target
	spr(tspr,tpos.x,tpos.y)
	
	--draw player
	spr(pspr,ppos.x,ppos.y)
	
	print(rot,8,8,7)
	print(ctrls.u,16,16,7)
	print(ctrls.l,8,24,7)
	print(ctrls.r,24,24,7)
	print(ctrls.d,16,32,7)
end

-->8
--helpers
function rnd_sign()
	return rnd({-1,1})
end

function rnd_int(
	val_srt,val_end
)
	local base
	base=flr(rnd(val_end+1-val_srt))
	return val_srt+base
end

__gfx__
00000000000000000000000090000009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000083333800000000009000090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700038be8300000000000900900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700003eaae3000000000000aa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700003baab3000000000000aa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700038eb8300000000000900900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000083333800000000009000090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000090000009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
