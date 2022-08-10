-- NC PROTECT+
server_scripts { '@nc_PROTECT+/exports/sv.lua' }
client_scripts { '@nc_PROTECT+/exports/cl.lua' }

fx_version "adamant"
game "gta5"

ui_page 'Interface/Interface.html'

client_script {
	'Secure.lua',
	'Source/Include.lua',
	'Source/Client.lua',
}

server_scripts {
	'Secure.lua',
	'Source/Include.lua',
}

files {
	'Interface/Interface.html',
	'Interface/Dynamic.css',
	'Interface/Function.js',
	'Interface/Sound/*.ogg',
	'Interface/img/*.png',
}