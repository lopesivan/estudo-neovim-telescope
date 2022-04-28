R('telescope')
R('plenary')

local async_static_finder = require('telescope.finders.async_static_finder')
local pickers             = require('telescope.pickers')
local conf                = require('telescope.config').values

local f = async_static_finder {
  ".ccls",
  ".ccls-root",
  ".projectile",
  ".projections.json",
  ".pyenv-vars",
  ".exrc",
  ".gitignore",
  ".local.vimrc",
  ".luaenv-vars",
  ".nvimrc",
  ".nvimrc.lua",
  ".tasks",
  "CMakeLists.txt",
  "Makefile",
  "package.json",
  "README.md",
  "tsconfig.json",
  "settings.gradle",
  "pom.xml",
  "build.haml",
}

pickers.new({}, {
  prompt_title = 'Async Finder',
  finder =  f,
  previewer = false,
  sorter = conf.file_sorter({}),
}):find()


