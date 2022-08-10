-- NC PROTECT+
server_scripts { '@nc_PROTECT+/exports/sv.lua' }
client_scripts { '@nc_PROTECT+/exports/cl.lua' }

fx_version 'adamant'

game 'gta5'

ui_page 'html/annoucer.html'

files {
    'html/annoucer.html',
    'html/img/logo.png',
    'html/style.css',
    'html/script.js',
    'html/waterdrop.mp3'
}

client_scripts {
    'config.lua',
    'client/main.lua'
}
server_scripts {
    'config.lua',
    'server/main.lua'
}