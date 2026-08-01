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
--*add player sprite animation
--sprite
--*mirror controls
--*show control map on screen
--*add collision detection
--*implement state machine
--*prepare home screen
--*make playable single level
--*implement level timer
--*add animation to control map
--change

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
	pspr=5
	--player position
	ppos={x=60,y=60}
	
	--target sprite
	tspr={1,2}
	--target sprite animation pointer
	tsprp=1
	--target sprite animation clock
	tsprclk=0
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
		if ppos.x<0 then
		 ppos.x=0
		end
	end
	if btn(ctrls.r) then
		ppos.x+=1
		if ppos.x>119 then
		 ppos.x=119
		end
	end
	if btn(ctrls.u) then
		ppos.y-=1
		if ppos.y<0 then
			ppos.y=0
		end
	end
	if btn(ctrls.d) then
		ppos.y+=1
		if ppos.y>111 then
			ppos.y=111
		end
	end

	--target animation
	tsprclk+=1
	if tsprclk>=16 then
		tsprclk=0
		tsprp+=1
		if tsprp>2 then
			tsprp=1
		end
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
	spr(tspr[tsprp],tpos.x,tpos.y)
	
	--draw player
	palt(14, true)
	spr(pspr,ppos.x,ppos.y,2,2)
	palt()
	
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
000000000000000000000000eeeeeee0000eeeeeeeeeee00000eeeeeeeeeee00000eeeeeeeeeeeeeeeeeeeeeeeeee000eeeeeeeeeeeee000eeeeeeee00000000
000000000833338003338330eeeeee033ff30eeeeeeee03ff330eeeeeeeee033ff300eeeeeeeee00000eeeeeeeee00000eeeeeeeeeee00000eeeeeee00000000
00700700038be83003be8b30eeee0033300300eeeeee0030033300eeeeee03ff330ff0eeeeeee033ff300e0eeeee0ffff0eeeeeeeeee0ffff0eeeeee00000000
0007700003eaae30088aae30eee0f03ffff00f0eeee0f00ffff30f0eeee0330330ff3000eeee03ff330ff00eee00f0000f00eeeeee00f0000f00eeee00000000
0007700003baab3003eaa880eee0f0f0000f0f0eeee0f0f0000f0f0eee0330f00ff3000eeee0330330ff300ee0f003ff300f0eeee0f003ff300f0eee00000000
00700700038eb83003b8eb30eee0f00000000f0eeee0f00000000f0eee0330f303000eeeee0330f00ff300eee0f033ff330f000ee0f033ff330f000e00000000
000000000833338003383330eee033000000330eee0033000000330eeee030ff00f0f00eee0330f303000eeee0f0303f330f0f0ee0f0303f330f0f0e00000000
000000000000000000000000e0000ff0ff0ff0eee0f00ff0ff0ff0eeeeee00ff0ff0ff0eeee030ff00f0f00ee030033f33030f0ee030033f33030f0e00000000
000000000000000000000000e0ff03f0ff0f30eee0f003f0ff0f30eee0000000ffff30eeee0000000ff0ff0eee00033330000f0eee00033330000f0e00000000
000000000000000000000000e03ff03ffff3030ee0f0303ffff3030ee0ff0ff033330eeeee0ff0ff0fff30eeee03033303030f0eee03033303030f0e00000000
000000000000000000000000e033f000000003f0e0f0f0000000030ee0f3f3f000000eeeee0f3f3f00000eeee0f3033033030f0ee0f3033033030f0e00000000
000000000000000000000000e033f0f0333300f0ee00f033330ff30ee0f000f0ff030eeeee0f000f0ff0eeeee0f030033f300f0ee0f030033f300f0e00000000
000000000000000000000000e033f0f0ffff300eee0003ffff0ff0eee0f333f0ff0f0eeeee0f333f0ff0eeeeee03fffff3300f0eee03fffff3300f0e00000000
000000000000000000000000ee00f003330000eeeee00000333000eee0f333f000030eeeee0f333f00000eeeee003333300000eeee003333300000ee00000000
000000000000000000000000eee0000000ff300eeeee0ff30000000ee00fff0fff000eeeee00fff00ffff0eeee0000000ff00eeeee0000000ff00eee00000000
000000000000000000000000eeeee000000000eeeeeee000000000eeeee00000000000eeeeee0000000000eeeee000000000eeeeeee000000000eeee00000000
