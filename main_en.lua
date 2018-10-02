-- $Name:Wolf, Goat and Cabbage$
-- $Version:1.0.0$

instead_version "1.3.0"

game.act = 'Action is undefined.';
game.inv = "Inventory is undefined";
game.use = 'Use is undefined';

main = room
{
	nam = 'Wolf, Goat and Cabbage',
	act = function() -- only one vobj, no check, just goto
		goto('bankLeft');
	end,
	dsc = "This is tha famous logical puzzle."..[[^^
	Implementation: Danil Korotenko (danil.korotenko@gmail.com).]],
	obj = { vway("next", "Click {here} to play.", 'bankLeft') }
};

wolf = obj
{
	nam = 'Wolf',
	dsc = '{Wolf} is sitting near.',
	act = function(s)
		if inv():srch('boat') then
			p 'You cannot call wolf when you in the boat.';
		else
			p 'You called wolf.';
			inv():add('wolf');
			objs():del('wolf');
		end;
	end,
	inv = function(s)
		p '"Go for a walk!" - you commanded to wolf.';
		objs():add(s);
		inv():del(s);
	end,
	use = function(s, w)
		if w ~= boat then
    		return false
		else
			if #boat.obj == 0 then
				inv():del(wolf);
				boat.obj:add('wolfOnBoat');
				p 'You taked wolf to boat.';
			else
				p 'You cannot put in the boat more then one object.'
		        return false
			end
		end
	end
};

wolfOnBoat = obj
{
	nam = 'Wolf',
	dsc = '{Wолк} is sitting in the boat.',
	tak = 'Wolf is looking at you carefully.',
	inv = function(s)
		if not inv():srch('boat') then
			p 'You bringed wolf to the river bank.';
			objs():add('wolf');
			inv():del('wolfOnBoat');
			if objs():srch(cabbage) and objs():srch(goat) and objs():srch(wolf) then
				goto('gameEnd');
			end;
		else
			p 'You cannot bring wolf to the river bank when you in the boat.'
		end
	end,
	use = function(s, w)
		if w ~= boat then
            return false
		else
			inv():del(s);
			boat.obj:add('wolfOnBoat');
			p 'You taked wolf to boat.';
		end
	end
};

goat = obj
{
	nam = 'Goat',
	dsc = '{Goat} is staying near and it looking into the distance.',
	act = function(s)
		if inv():srch('boat') then
			p 'You cannot get the goat when you in the boat.';
		else
			p 'You got the goat.';
			inv():add('goat');
			objs():del('goat');
		end;
	end,
	inv = function(s)
		p 'You bringed goat to the river bank.';
		objs():add(s);
		inv():del(s);
	end,
	use = function(s, w)
		if w ~= boat then
            return false
		else
			if #boat.obj == 0 then
				inv():del(goat);
				boat.obj:add('goatOnBoat');
				p 'You taked goat to the boat.';
			else
				p 'You cannot put in the boat more then one object.'
                return false
			end
		end
	end
};

goatOnBoat = obj
{
	nam = 'Goat',
	dsc = '{Goat} is staying in the boat and looking to the distance.',
	tak = 'You got the goat.',
	inv = function(s)
		if not inv():srch('boat') then
			p 'You bringed goat to the river bank.';
			objs():add('goat');
			inv():del('goatOnBoat');
			if objs():srch(cabbage) and objs():srch(goat) and objs():srch(wolf) then
				goto('gameEnd');
			end;
		else
			p 'You cannot bring the goat to the river bank when you in the boat.'
		end
	end,
	use = function(s, w)
		if w ~= boat then
			return false
		else
			inv():del(s);
			boat.obj:add('goatOnBoat');
			p 'You taked goat to the boat.';
		end
	end
};

cabbage = obj
{
	nam = 'Cabbage',
	dsc = '{Cabbage} is laying on the ground.',
	act = function(s)
		if inv():srch('boat') then
			p 'You cannot take the cabbage when you in the boat.';
		else
			p 'You taked cabbage.';
			inv():add('cabbage');
			objs():del('cabbage');
		end;
	end,
	inv = function(s)
		p 'You putted cabbage to the ground.';
		objs():add(s);
		inv():del(s);
	end,
	use = function(s, w)
		if w ~= boat then
            return false
		else
			if #boat.obj == 0 then
				inv():del(s);
				boat.obj:add('cabbageOnBoat');
				p 'You put cabbage to the boat.';
			else
				p 'You cannot put in the boat more then one object.'
		        return false
			end
		end
	end
};

cabbageOnBoat = obj
{
	nam = 'Cabbage',
	dsc = '{Cabbage} is laying in the boat.',
	tak = 'You got the cabbage.',
	inv = function(s)
		if not inv():srch('boat') then
			p 'You put tha cabbage to the ground.';
			objs():add('cabbage');
			inv():del('cabbageOnBoat');
			if objs():srch(cabbage) and objs():srch(goat) and objs():srch(wolf) then
				goto('gameEnd');
			end;
		else
			p 'You cannot put the cabbage to the ground when you in the boat.'
		end
	end,
	use = function(s, w)
		if w ~= boat then
            return false
		else
			inv():del(s);
			boat.obj:add('cabbageOnBoat');
			p 'You put the cabbage back to the boat.';
		end
	end
};

boat = obj
{
	nam = 'Boat',
	dsc = 'A little {boat} is near the river bank.',
	act = function(s)
		if inv():srch(cabbage) then
			p 'You cannot got on the boat with cabbage in your hands.';
		else
			if inv():srch(wolf) then
				p 'You cannot got on the boat with the wolf at the same time.';
			else
				if inv():srch(goat) then
					p 'You cannot got on the boat with the goat at the same time.';
				else
					if where(me()) == bankLeft then
						ways():add('bankRight');
						ways('bankRight'):add('bankLeft');
						inv():add('boat');
						objs():del('boat');
					else
						if where(me()) == bankRight then
							ways():add('bankLeft');
							ways('bankLeft'):add('bankRight');
							inv():add('boat');
						end;
					end;
					p 'You got on the boat.';
				end;
			end;
		end;
	end,
	inv = function(s)
		p 'you got out from the boat.';
		inv():del(s);
		objs():add(s);
		ways():zap();
	end
};

bankLeft = room
{
	nam = 'Left Bank',
	dsc = 'This is the left bank.',
	enter = function(s, f)
		if f == bankRight then
			if objs(bankLeft):srch('wolf') then
				if objs(bankLeft):srch('goat') then
					p 'Wolf eat goat.';
					objs(bankLeft):del(goat);
					goto(gameOver);
				end;
			else
				if objs(bankLeft):srch('goat') then
					if objs(bankLeft):srch('cabbage') then
						p 'Goat eat cabagge.';
						objs(bankLeft):del(cabbage);
						goto(gameOver);
					end;
				end;
			end;
		end;
	end
};

function init()
	bankLeft.obj:add('wolf');
	bankLeft.obj:add('goat');
	bankLeft.obj:add('cabbage');
	bankLeft.obj:add('boat');
end

bankRight = room
{
	nam = 'Right Bank',
	dsc = 'Thi is the right bank.',
	enter = function(s, f)
		if f == bankLeft then
			if objs(bankRight):srch('wolf') then
				if objs(bankRight):srch('goat') then
					p 'Wolf eat goat.';
					objs(bankRight):del(goat);
					goto(gameOver);
				end;
			else
				if objs(bankRight):srch('goat') then
					if objs(bankRight):srch('cabbage') then
						p 'Goat eat cabagge.';
						objs(bankRight):del(cabbage);
						goto(gameOver);
					end;
				end;
			end;
		end;
	end
};

gameOver = room
{
	nam = 'Mission failed.',
	dsc = 'Game over.',
}

gameEnd = room
{
	nam = 'Mission completed.',
	dsc = 'Congratulations!',
}
