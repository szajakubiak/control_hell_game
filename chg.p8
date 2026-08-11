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
--*mirror controls
--*show control map on screen
--*add collision detection
--*prepare home screen
--*make playable single level
--*implement level timer
--*add animation to control map
--change

-->8
--init
function _init()
	--game state
	state="game"
	if state=="game" then
		init_game()
	end
end

function init_game()
	--controls map
	ctrls={
		l=⬅️,
		r=➡️,
		u=⬆️,
		d=⬇️,
	}
	--player
	plyr={}
	--player sprite
	plyr.spr=3
	--player position
	plyr.pos={x=60,y=60}
	
	--target sprite
	tspr={1,2}
	--target sprite animation pointer
	tsprp=1
	--target sprite animation clock
	tsprclk=0
	--target position
	tpos={}
	tpos.x=plyr.pos.x
	tpos.x+=rnd_sign()*rnd_int(25,60)
	tpos.y=plyr.pos.y
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
	if state=="game" then
		update_game()
	end
end

function update_game()
	if btn(ctrls.l) then
		plyr.pos.x-=1
		if plyr.pos.x<0 then
		 plyr.pos.x=0
		end
	end
	if btn(ctrls.r) then
		plyr.pos.x+=1
		if plyr.pos.x>111 then
		 plyr.pos.x=111
		end
	end
	if btn(ctrls.u) then
		plyr.pos.y-=1
		if plyr.pos.y<0 then
			plyr.pos.y=0
		end
	end
	if btn(ctrls.d) then
		plyr.pos.y+=1
		if plyr.pos.y>111 then
			plyr.pos.y=111
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
	if state=="game" then
		draw_game()
	end
end

function draw_game()
	cls()
	
	--draw target
	spr(tspr[tsprp],tpos.x,tpos.y)
	
	--draw player
	palt(14, true)
	spr(plyr.spr,plyr.pos.x,plyr.pos.y,2,2)
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
000000000000000000000000eeeeeee0000eeeeeeeeeee00000eeeeeeeeeee00000eeeeeeeeeeeeeeeeeeeeeeeeee000eeeeeeeeeeeeeeee000eeeee00000000
000000000833338003338330eeeeee033ff30eeeeeeee03ff330eeeeeeeee033ff300eeeeeeeee00000eeeeeeeee00000eeeeeeeeeeeeee00000eeee00000000
00700700038be83003be8b30eeee0033300300eeeeee0030033300eeeeee03ff330ff0eeeeeee033ff300e0eeeee0ffff0eeeeeeeeeeee0ffff0eeee00000000
0007700003eaae30088aae30eee0f03ffff00f0eeee0f00ffff30f0eeee0330330ff3000eeee03ff330ff00eee00f0000f00eeeeeeee00f0000f00ee00000000
0007700003baab3003eaa880eee0f0f0000f0f0eeee0f0f0000f0f0eee0330f00ff3000eeee0330330ff300ee0f003ff300f0eeeeee0f003ff300f0e00000000
00700700038eb83003b8eb30eee0f00000000f0eeee0f00000000f0eee0330f303000eeeee0330f00ff300eee0f033ff330f000eeee0f033ff330f0e00000000
000000000833338003383330eee033000000330eee0033000000330eeee030ff00f0f00eee0330f303000eeee0f0303f330f0f0eee00f033f3030f0e00000000
000000000000000000000000e0000ff0ff0ff0eee0f00ff0ff0ff0eeeeee00ff0ff0ff0eeee030ff00f0f00ee030033f33030f0ee0f03033f330030e00000000
000000000000000000000000e0ff03f0ff0f30eee0f003f0ff0f30eee0000000ffff30eeee0000000ff0ff0eee00033330000f0ee03f0003333000ee00000000
000000000000000000000000e03ff03ffff3030ee0f0303ffff3030ee0ff0ff033330eeeee0ff0ff0fff30eeee03033303030f0ee03f0330333030ee00000000
000000000000000000000000e033f000000003f0e0f0f0000000030ee0f3f3f000000eeeee0f3f3f00000eeee0f3033033030f0ee03f03330330330e00000000
000000000000000000000000e033f0f0333300f0ee00f033330ff30ee0f000f0ff030eeeee0f000f0ff0eeeee0f030033f300f0ee03f00f33003030e00000000
000000000000000000000000e033f0f0ffff300eee0003ffff0ff0eee0f333f0ff0f0eeeee0f333f0ff0eeeeee03fffff3300f0ee03f003fffff30ee00000000
000000000000000000000000ee00f003330000eeeee00000333000eee0f333f000030eeeee0f333f00000eeeee003333300000eeee003333300000ee00000000
000000000000000000000000eee0000000ff300eeeee0ff30000000ee00fff0fff000eeeee00fff00ffff0eeee0000000ff00eeeeee00ff0000000ee00000000
000000000000000000000000eeeee000000000eeeeeee000000000eeeee00000000000eeeeee0000000000eeeee000000000eeeeeeee000000000eee00000000
