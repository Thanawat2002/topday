resource_manifest_version "05cfa83c-a124-4cfa-a768-c24a5811d8f9"

description 'NC COMMUNITY GACHAPON'

ui_page 'html/html.html'

version '1.4'

client_scripts {
  "config.lua",
  "client/main.lua"
}

server_script {
  '@mysql-async/lib/MySQL.lua',
  "config.lua",
  "server/server.lua",
}

files {
  "html/**"
}
