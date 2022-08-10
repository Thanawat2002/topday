fx_version 'adamant'

game 'gta5'

description 'What Emotes (DPEMOTES EDIT)'

client_scripts {
    'config.lua',
	'core/list.lua',
    'core/function.lua',
    'core/client.lua',
}

server_scripts {
	'core/server.lua',
}

ui_page 'dist/index.html'

files {
	'dist/css/app.css',
	'dist/js/app.js',
	'dist/index.html',
	'dist/sound/*.ogg',
}

exports {
	'checkOpenEmote'
}