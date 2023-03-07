local M = {}

local success, flippers = pcall(function()
  local flipper_file = './config/feature-descriptions.yml'
  local flippers = {}

  for line in io.lines(flipper_file) do
    local name, description = line:match('^([A-Za-z_]+): (.+)$')

    if name and description then
      if not (name == 'ROLLOUT_test_feature_with_description') then
        flippers[name] = description
      end
    end
  end

  return flippers
end)
if not success then
  return
end

function M.all(prefix)
  if prefix == 'featureEnabled' then
    local js_flippers = {}

    for name, description in pairs(flippers) do
      local new_name = name:match('_([_a-z]+)')
      new_name = new_name:gsub('enable_', ''):gsub('disable_', '')

      js_flippers[new_name] = description
    end
    return js_flippers
  else
    return flippers
  end
end

function M.valid_prefix(prefix)
  if prefix == nil or prefix == '' then
    return false
  end

  local valid_prefixes = {
    'Features.enabled?',
    'Features.feature_enabled?',
    'featureEnabled',
    'feature_enabled?',
    'with_feature',
    'without_feature',
  }

  local match = false

  for _, valid_prefix in pairs(valid_prefixes) do
    if vim.startswith(prefix, valid_prefix) then
      match = true
      break
    end
  end

  return match
end

return M
