-- $Name:Волк, Коза и Капуста$
-- $Version:1.0.0$

instead_version "1.3.0"

game.act = 'Не получается.';
game.inv = "Гм.. Не то..";
game.use = 'Не сработает...';

main = room {
	nam = 'Волк, Коза и Капуста',
	act = function() -- only one vobj, no check, just goto
		goto('bankLeft');
	end,
	dsc = "Всем известная логческая игра."..[[^^
	Реализация: Данил Коротенко (danil.korotenko@gmail.com).]],
	obj = { vway("дальше", "Нажмите {здесь} чтобы начать игру.", 'bankLeft') }
};

wolf = obj {
	nam = 'Волк',
	dsc = 'Прирученый {волк} сидит недалеко от вас.',
	act = function(s)
		if inv():srch('boat') then
			p 'Вы не можете подозвать к себе волка сидя в лодке.';
		else
			p 'Вы подозвали волка к себе.';
			inv():add('wolf');
			objs():del('wolf');
		end;
	end,
	inv = function(s)
		p '"Гулять!" сказали вы волку.';
		objs():add(s);
		inv():del(s);
	end,
	use = function(s, w)
		if w ~= boat then
			p 'Не полчится.'
                        return false
		else
			if #boat.obj == 0 then
				inv():del(wolf);
				boat.obj:add('wolfOnBoat');
				p 'Вы заводите волка в лодку.';
			else
				p 'В лодке уже кто то сидит.'
		                return false
			end
		end
	end
};

wolfOnBoat = obj {
	nam = 'Волк',
	dsc = 'Прирученый {волк} сидит в лодке.',
	tak = 'Волк теперь смотрит на вас внимательно.',
	inv = function(s)
		if not inv():srch('boat') then
			p 'Вы выводите волка на берег.';
			objs():add('wolf');
			inv():del('wolfOnBoat');
			if objs():srch(kapusta) and objs():srch(goat) and objs():srch(wolf) then
				goto('gameEnd');
			end;
		else
			p 'Вы не можете вывести волка на берег сидя в лодке.'
		end
	end,
	use = function(s, w)
		if w ~= boat then
			p 'Не полчится.'
                        return false
		else
			inv():del(s);
			boat.obj:add('wolfOnBoat');
			p 'Вы заводите волка обратно в лодку.';
		end
	end
};

goat = obj {
	nam = 'Коза',
	dsc = 'Рядом стоит {коза} и смотрит вдаль. На {козу} одет ошейник, к ошейнику привязана веревочка.',
	act = function(s)
		if inv():srch('boat') then
			p 'Вы не можете взять козу за веревочку сидя в лодке.';
		else
			p 'Вы взяли козу за веревочку.';
			inv():add('goat');
			objs():del('goat');
		end;
	end,
	inv = function(s)
		p 'Вы выводите козу на берег.';
		objs():add(s);
		inv():del(s);
	end,
	use = function(s, w)
		if w ~= boat then
			p 'Не полчится.'
                        return false
		else
			if #boat.obj == 0 then
				inv():del(goat);
				boat.obj:add('goatOnBoat');
				p 'Вы заводите козу в лодку.';
			else
				p 'В лодке уже кто то сидит.'
		                return false
			end
		end
	end
};

goatOnBoat = obj {
	nam = 'Коза',
	dsc = 'В лодке стоит {Коза} и смотрит вдаль.',
	tak = 'Вы взяли козу за веревочку.',
	inv = function(s)
		if not inv():srch('boat') then
			p 'Вы выводите козу на берег.';
			objs():add('goat');
			inv():del('goatOnBoat');
			if objs():srch(kapusta) and objs():srch(goat) and objs():srch(wolf) then
				goto('gameEnd');
			end;
		else
			p 'Вы не можете вывести козу на берег сидя в лодке.'
		end
	end,
	use = function(s, w)
		if w ~= boat then
			p 'Не полчится.'
                        return false
		else
			inv():del(s);
			boat.obj:add('goatOnBoat');
			p 'Вы заводите козу обратно в лодку.';
		end
	end
};

kapusta = obj {
	nam = 'Капуста',
	dsc = 'На земле лежит большой кочан {капусты}.',
	act = function(s)
		if inv():srch('boat') then
			p 'Вы не можете взять капусту с земли сидя в лодке.';
		else
			p 'Вы взяли капусту в руки.';
			inv():add('kapusta');
			objs():del('kapusta');
		end;
	end,
	inv = function(s)
		p 'Вы кладете капусту на землю.';
		objs():add(s);
		inv():del(s);
	end,
	use = function(s, w)
		if w ~= boat then
			p 'Не полчится.'
                        return false
		else
			if #boat.obj == 0 then
				inv():del(s);
				boat.obj:add('kapustaOnBoat');
				p 'Вы кладете капусту в лодку.';
			else
				p 'В лодке уже кто то сидит.'
		                return false
			end
		end
	end
};

kapustaOnBoat = obj {
	nam = 'Капуста',
	dsc = 'В лодке лежит большой кочан {капусты}.',
	tak = 'Вы взяли капусту в руки.',
	inv = function(s)
		if not inv():srch('boat') then
			p 'Вы кладете капусту на землю.';
			objs():add('kapusta');
			inv():del('kapustaOnBoat');
			if objs():srch(kapusta) and objs():srch(goat) and objs():srch(wolf) then
				goto('gameEnd');
			end;
		else
			p 'Вы не можете положить капусту на землю сидя в лодке.'
		end
	end,
	use = function(s, w)
		if w ~= boat then
			p 'Не полчится.'
                        return false
		else
			inv():del(s);
			boat.obj:add('kapustaOnBoat');
			p 'Вы кладете капусту обратно в лодку.';
		end
	end
};

boat = obj {
	nam = 'Лодка',
	dsc = 'У берега стоит маленькая {лодочка}.',
	act = function(s)
		if inv():srch(kapusta) then
			p 'Вы не можете залезть в лодку с капустой в руках.';
		else 
			if inv():srch(wolf) then
				p 'Вы не можете залезть в лодку с волком одновременно.';
			else 
				if inv():srch(goat) then
					p 'Вы не можете залезть в лодку с козой одновременно.';
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
					p 'Вы сели в лодку.';
				end;
			end;
		end;
	end,
	inv = function(s)
		p 'Вы вышли из лодки.';
		inv():del(s);
		objs():add(s);
		ways():zap();
	end
};

bankLeft = room {
	nam = 'Берег Левый',
	dsc = 'Это левый берег реки.',
	enter = function(s, f)
		if f == bankRight then
			if objs(bankLeft):srch('wolf') then
				if objs(bankLeft):srch('goat') then
					p 'Волк сожрал козу';
					objs(bankLeft):del(goat);
					goto(gameOver);
				end;
			else
				if objs(bankLeft):srch('goat') then
					if objs(bankLeft):srch('kapusta') then
						p 'Коза сожрала капусту';
						objs(bankLeft):del(kapusta);
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
	bankLeft.obj:add('kapusta');
	bankLeft.obj:add('boat');
end

bankRight = room {
	nam = 'Берег Правый',
	dsc = 'Это правый берег реки.',
	enter = function(s, f)
		if f == bankLeft then
			if objs(bankRight):srch('wolf') then
				if objs(bankRight):srch('goat') then
					p 'Волк сожрал козу';
					objs(bankRight):del(goat);
					goto(gameOver);
				end;
			else
				if objs(bankRight):srch('goat') then
					if objs(bankRight):srch('kapusta') then
						p 'Коза сожрала капусту';
						objs(bankRight):del(kapusta);
						goto(gameOver);
					end;
				end;
			end;
		end;
	end
};

gameOver = room {
	nam = 'Миссия провалена.',
	dsc = 'Игра закончена.',
}

gameEnd = room {
	nam = 'Миссия выполнена.',
	dsc = 'Поздравляем! Вы успешно закончили игру.',
}
