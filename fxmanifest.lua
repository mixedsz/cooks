fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'flake_cooking'
author 'flake-scripts'
description 'An advanced cooking script that allows you to cook food and create drinks also.'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config/config.lua',
    'config/appliances.lua',
    'config/recipes.lua',
    'config/decorations.lua',
    'config/stores.lua',
    'config/notify_wrapper.lua',
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
}

files {
    'build/assets/*',
    'build/*'
}

ui_page 'build/index.html'

dependencies {
    'ox_lib',
    'ox_target',
    'ox_inventory',
    'object_gizmo'
}

escrow_ignore {
    'config/*.lua',
    'install/*.lua'
}
dependency '/assetpacks'