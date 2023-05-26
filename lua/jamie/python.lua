
-- determine where the ipython installation is
-- this is different depending on the machine
local homepath = os.getenv("HOMEPATH"):gsub("\\", "/")
COMPUTER_LOCATION = '~'
if string.find(homepath, "u209454") then
    print("Trane Computer")
    COMPUTER_LOCATION = 'Trane'
    PYTHON_ENV = os.getenv("VIRTUAL_ENV")
    if PYTHON_ENV ~= nil then
        PYTHON_ENV = gsub(PYTHON_ENV, "\\", "/")
        PYTHON_ENV_NAME = string.match(PYTHON_ENV,".virtualenvs/(.+)$")
    end
else
    print("Home Computer")
    COMPUTER_LOCATION = 'Home'
    PYTHON_ENV = os.getenv("CONDA_PREFIX")
    if PYTHON_ENV ~= nil then
        PYTHON_ENV = gsub(PYTHON_ENV, "\\", "/")
        PYTHON_ENV_NAME = string.match(PYTHON_ENV,"envs/(.+)$")
    end
    -- TODO find environment name from conda
end
if PYTHON_ENV == nil then
    PYTHON_ENV = '~'
    PYTHON_ENV_NAME = '~'
end

if COMPUTER_LOCATION == 'Trane' then 
    vim.g.python3_host_prog = PYTHON_ENV .. "/Scripts/python.exe"
    vim.g.python = PYTHON_ENV .. "/Scripts/python.exe"
else
    vim.g.python3_host_prog = PYTHON_ENV .. "/python.exe"
    vim.g.python = PYTHON_ENV .. "/python.exe"
end

-- python path
vim.g.python_style = 'numpy'

