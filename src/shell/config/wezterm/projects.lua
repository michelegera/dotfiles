local wezterm = require 'wezterm'

local module = {}
local base_dir = wezterm.home_dir .. '/Code/*'

-- Gather all the directories in the base_dir
local function project_dirs()
  local projects = {}

  -- Use wezterm.glob to list all directories in base_dir and add them to the projects table
  for _, dir in ipairs(wezterm.glob(base_dir .. '/*')) do
    table.insert(projects, dir)
  end

  return projects
end

-- Allow the user to choose a project directory using an input selector
function module.choose_project()
  local choices = {}

  -- Populate the choices table with directory labels returned by project_dirs()
  for _, value in ipairs(project_dirs()) do
    table.insert(choices, { label = value })
  end

  -- Display an input selector with the available projects
  return wezterm.action.InputSelector {
    title = "Projects",            -- Set the title of the selector window
    choices = choices,             -- Provide the list of available projects
    fuzzy = true,                  -- Enable fuzzy matching for easier searching
    action = wezterm.action_callback(function(child_window, child_pane, id, label)
      if not label then return end -- Ensure a valid label is selected

      -- Switch to the selected workspace, using the project name as the workspace name
      child_window:perform_action(wezterm.action.SwitchToWorkspace {
        name = label:match("([^/]+)$"), -- Extract the last part of the path as the workspace name
        spawn = { cwd = label },        -- Set the working directory to the selected project
      }, child_pane)
    end),
  }
end

return module
