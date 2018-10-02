-- $Name:Wolf, Goat and Cabbage$
-- $Name(ru):Волк, Коза и Капуста$

instead_version "1.6.0"
require "xact"

game_lang = {
	ru = 'Язык',
	en = 'Language',
}

game_title = {
	ru = 'Волк, Коза и Капуста',
	en = 'Wolf, Goat and Cabbage',
}

if not LANG or not game_lang[LANG] then
	LANG = "en"
end

game_lang = game_lang[LANG]
game_title = game_title[LANG]

main = room {
	nam = game_title;
	pic = 'instead.png';
	forcedsc = true;
	dsc = txtc (
		txtb(game_lang)..'^^'..
		img('gb.png')..' '..[[{en|English}^]]..
		img('ru.png')..' '..[[{ru|Русский}^]]..
		'');
	obj = {
		xact("ru", code [[ gamefile('main-ru.lua', true) ]]);
		xact("en", code [[ gamefile('main-en.lua', true) ]]);
	}
}
