--
-- Notion main configuration file
--
-- This file only includes some settings that are rather frequently altered.
-- The rest of the settings are in cfg_notioncore.lua and individual modules'
-- configuration files (cfg_modulename.lua). 

META="Mod4+"
--ALTMETA=""

-- Terminal emulator
XTERM="urxvt -sk -sr -si -sl 5000 -scrollstyle plain -urgentOnBell"

-- Some basic settings
ioncore.set{
    -- Maximum delay between clicks in milliseconds to be considered a
    -- double click.
    dblclick_delay=250,

    opaque_resize=true,

    -- Don't move the mouse cursor when changing frames with the keyboard
    warp=false,

    -- Default index for windows in frames: one of 'last', 'next' (for
    -- after current), or 'next-act' (for after current and anything with
    -- activity right after it).
    frame_default_index='next-act',
    
    -- Auto-unsqueeze transients/menus/queries.
    unsqueeze=true,
    
    -- Display notification tooltips for activity on hidden workspace.
    -- This is awesome in conjunction with urgentOnBell and a bell in the PROMPT
    screen_notify=true,
}

dopath("cfg_defaults")

