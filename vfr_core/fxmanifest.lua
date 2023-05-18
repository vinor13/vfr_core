fx_version 'cerulean'
game 'gta5'

shared_script 'cfg.lua'

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua',
    '@oxmysql/lib/MySQL.lua',
}

shared_scripts {
    'shared.lua'
}