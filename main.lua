print 'start of main.lua...'

require 'freeze'
local frozen_env = freeze.frozen(_G)
setfenv(1, frozen_env)

require 'classes'
require 'lists'
require 'examine'