local flippers = require('cmp_feature_flipper.flippers')

local source = {}

source.new = function()
  return setmetatable({}, { __index = source })
end

source.is_available = function()
  return vim.fn.filereadable('./config/feature-descriptions.yml') == 1
end

source.get_trigger_characters = function()
  return { ':', '"', "'" }
end

source.complete = function(_, request, callback)
  local input = string.sub(request.context.cursor_before_line, request.offset - 1)
  local prefix = string.sub(request.context.cursor_before_line, 1, request.offset - 1)
  local trigger_character = string.sub(input, 1, 1)

  local filtered_prefix = prefix:match('(%g+)%([\"\':]$')

  if (vim.startswith(input, ':') or vim.startswith(input, "'") or vim.startswith(input, '"')) and flippers.valid_prefix(filtered_prefix) then
    local items = {}
    for name, documentation in pairs(flippers.all(filtered_prefix)) do

      -- if trigger_character == ':' then name = (":" .. name) end

      local cmp_item = {
        filterText = name,
        label = name,
        documentation = documentation,
        textEdit = {
          newText = trigger_character .. name,
          range = {
            start = {
              line = request.context.cursor.row - 1,
              character = request.context.cursor.col - 1 - #input,
            },
            ['end'] = {
              line = request.context.cursor.row - 1,
              character = request.context.cursor.col - 1,
            },
          },
        },
      }

      table.insert(items, cmp_item)
    end

    callback {
      items = items,
      isIncomplete = true,
    }
  else
    callback { isIncomplete = true }
  end
end

return source
