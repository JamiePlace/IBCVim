local iron = require("iron.core")

-- determine where the ipython installation is
-- this is different depending on the machine
local homepath = os.getenv("HOMEPATH")

if string.find(homepath, "u209454") then
    print("Trane Computer")
    python_env = os.getenv("VIRTAUL_ENV")
else
    print("Home Computer")
    python_env = os.getenv("CONDA_PREFIX")
end
if python_env == nil then
    python_env = '~'
end


iron.setup {
  config = {
    -- Whether a repl should be discarded or not
    scratch_repl = true,
    -- Your repl definitions come here
    repl_definition = {
        python = {
            command = {python_env .. "/Scripts/ipython3"}
        } 
    },
    -- How the repl window will be displayed
    -- See below for more information
    repl_open_cmd = require('iron.view').right("40%"),
  },
  -- Iron doesn't set keymaps by default anymore.
  -- You can set them here or manually add keymaps to the functions in iron.core
  keymaps = {
    --send_motion = "<space>sc",
    --visual_send = "<space>sc",
    send_file = "<space>sf",
    send_line = "<space>sc",
    send_mark = "<space>sm",
    mark_motion = "<space>mc",
    mark_visual = "<space>mc",
    remove_mark = "<space>md",
    --cr = "<C-e>",
    interrupt = "<space>s<space>",
    exit = "<space>sq",
    clear = "<space>cl",
  },
  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  highlight = {
    italic = true
  },
  ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
}

