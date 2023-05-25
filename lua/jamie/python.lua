
-- determine where the ipython installation is
-- this is different depending on the machine
local homepath = os.getenv("HOMEPATH")
if string.find(homepath, "u209454") then
    print("Trane Computer")
    PYTHON_ENV = os.getenv("VIRTUAL_ENV")
    if PYTHON_ENV ~= nil then
        PYTHON_ENV_NAME = string.match(PYTHON_ENV,".virtualenvs\\(.+)$")
    end
else
    print("Home Computer")
    PYTHON_ENV = os.getenv("CONDA_PREFIX")
    -- TODO find environment name from conda
end
if PYTHON_ENV == nil then
    PYTHON_ENV = '~'
    PYTHON_ENV_NAME = '~'
end


