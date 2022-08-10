-- NC PROTECT+
server_scripts { '@nc_PROTECT+/exports/sv.lua' }
client_scripts { '@nc_PROTECT+/exports/cl.lua' }

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Scoreboard'

version '1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	"@vSql/vSql.lua",
	'server.lua'
}

client_scripts {
	'client.lua',
	'config.lua'
}

ui_page "html/ui.html"

files {
	"html/*",
	"html/logo.png"
}