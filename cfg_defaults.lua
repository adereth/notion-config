--
-- Notion default settings
--

dopath("cfg_keyboard")
dopath("cfg_mouse")
dopath("cfg_menuitems")
dopath("cfg_kludges")
dopath("cfg_layouts")

if os and os.execute("test -r ~/.notion/cfg_local.lua") == 0 then
    dopath("cfg_local") -- Anything that you don't want to share across machines
end

dopath("mod_query")
dopath("mod_menu")
dopath("mod_tiling")
dopath("mod_sp")
