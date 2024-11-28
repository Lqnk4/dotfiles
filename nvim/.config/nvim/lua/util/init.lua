return setmetatable({}, {
  __index = function(_, key)
    return require('util.' .. key)
  end,
})
