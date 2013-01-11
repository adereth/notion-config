--
-- Notion core configuration file
--

-- WScreen context bindings
-- The bindings in this context are available all the time.
defbindings("WScreen", {
    
    bdoc("Switch to next/previous desktop"),
    kpress(META.."bracketleft", "WScreen.switch_prev(_)"),
    kpress(META.."bracketright", "WScreen.switch_next(_)"),

    -- Focus moving goodness... Emacs style!
    kpress(META.."B", "ioncore.goto_next(_chld, 'left')"),
    kpress(META.."F", "ioncore.goto_next(_chld, 'right')"),
    kpress(META.."P", "ioncore.goto_next(_chld, 'up')"),
    kpress(META.."N", "ioncore.goto_next(_chld, 'down')"),

    bdoc("Go to first object on activity/urgency list."),
    -- This is killer in conjunction with using a terminal that
    -- raises urgent on bell and a bash prompt that contains a bell.
    kpress(META.."space", "ioncore.goto_activity()"),

    submap(META.."K", {
        kpress("K", "mod_menu.grabmenu(_, _sub, 'focuslist')"),
    }),

    bdoc("Clear all tags."),
    kpress(META.."Shift+T", "ioncore.tagged_clear()"),

    bdoc("Go to n:th screen on multihead setup."),
    kpress(META.."Shift+1", "ioncore.goto_nth_screen(0)"),
    kpress(META.."Shift+2", "ioncore.goto_nth_screen(1)"),
    
    bdoc("Go to next/previous screen on multihead setup."),
    kpress(META.."Shift+comma", "ioncore.goto_prev_screen()"),
    kpress(META.."Shift+period", "ioncore.goto_next_screen()"),
    
    bdoc("Create a new workspace of chosen default type."),
    kpress(META.."F9", "ioncore.create_ws(_)"),
    
    bdoc("Display the main menu."),
    kpress(ALTMETA.."F12", "mod_query.query_menu(_, _sub, 'mainmenu', 'Main menu:')"),
    
    mpress("Button3", "mod_menu.pmenu(_, _sub, 'mainmenu')"),
    
    bdoc("Display the window list menu."),
    mpress("Button2", "mod_menu.pmenu(_, _sub, 'windowlist')"),

})


-- Client window bindings
--
-- These bindings affect client windows directly.

defbindings("WClientWin", {
    bdoc("Nudge the client window. This might help with some "..
         "programs' resizing problems."),
    kpress_wait(META.."L", "WClientWin.nudge(_)"),
    
    bdoc("Send next key press to the client window. "),
    kpress(META.."apostrophe", "WClientWin.quote_next(_)"),

    submap(META.."K", {
       bdoc("Kill client owning the client window."),
       kpress("C", "WClientWin.kill(_)"),       
    }),
})


-- Client window group bindings

defbindings("WGroupCW", {
    bdoc("Toggle client window group full-screen mode"),
    kpress_wait(META.."Return", "WGroup.set_fullscreen(_, 'toggle')"),
})


-- WMPlex context bindings
--
-- These bindings work in frames and on screens. The innermost of such
-- contexts/objects always gets to handle the key press. 

defbindings("WMPlex", {
    bdoc("Close current object."),
    kpress_wait(META.."W", "WRegion.rqclose_propagate(_, _sub)"),
})

-- Frames for transient windows ignore this bindmap
defbindings("WMPlex.toplevel", {
    bdoc("Toggle tag of current object."),
    kpress(META.."T", "WRegion.set_tagged(_sub, 'toggle')", "_sub:non-nil"),

    bdoc("Run a terminal emulator."),
    kpress(ALTMETA.."F2", "notioncore.exec_on(_, XTERM or 'x-terminal-emulator')"),
    kpress(META.."X", "notioncore.exec_on(_, XTERM or 'x-terminal-emulator')"),
    
    bdoc("Query for command line to execute."),
    kpress(META.."R", "ioncore.exec_on(_, 'gmrun')"), -- "mod_query.query_exec(_)" for default executor
    kpress(ALTMETA.."F3", "ioncore.exec_on(_, 'gmrun')"),

    bdoc("Query for Lua code to execute."),
    kpress(META.."F3", "mod_query.query_lua(_)"),

    bdoc("Query for workspace to go to or create a new one."),
    kpress(ALTMETA.."F9", "mod_query.query_workspace(_)"),
    
    bdoc("Query for a client window to go to."),
    kpress(META.."G", "mod_query.query_gotoclient(_)"),
    
    bdoc("Display context menu."),
    --kpress(META.."M", "mod_menu.menu(_, _sub, 'ctxmenu')"),
    kpress(META.."M", "mod_query.query_menu(_, _sub, 'ctxmenu', 'Context menu:')"),

    bdoc("Detach (float) or reattach an object to its previous location."),
    -- By using _chld instead of _sub, we can detach/reattach queries
    -- attached to a group. The detach code checks if the parameter 
    -- (_chld) is a group 'bottom' and detaches the whole group in that
    -- case.
    kpress(META.."D", "ioncore.detach(_chld, 'toggle')", "_chld:non-nil"),
    
})


-- WFrame context bindings
--
-- These bindings are common to all types of frames. Some additional
-- frame bindings are found in some modules' configuration files.

defbindings("WFrame", {
    submap(META.."K", {
        bdoc("Maximize the frame horizontally/vertically."),
        kpress("H", "WFrame.maximize_horiz(_)"),
        kpress("V", "WFrame.maximize_vert(_)"),
    }),
    
    bdoc("Display context menu."),
    mpress("Button3", "mod_menu.pmenu(_, _sub, 'ctxmenu')"),
    
    -- Just start resizing by pressing META + Direction
    kpress(META.."Left",  "WFrame.begin_kbresize(_); WMoveresMode.resize(_, 1, 0, 0, 0)"),
    kpress(META.."Right", "WFrame.begin_kbresize(_); WMoveresMode.resize(_, 0, 1, 0, 0)"),
    kpress(META.."Up",    "WFrame.begin_kbresize(_); WMoveresMode.resize(_, 0, 0, 1, 0)"),
    kpress(META.."Down",  "WFrame.begin_kbresize(_); WMoveresMode.resize(_, 0, 0, 0, 1)"),

    bdoc("Switch the frame to display the object indicated by the tab."),
    mclick("Button1@tab", "WFrame.p_switch_tab(_)"),
    mclick("Button2@tab", "WFrame.p_switch_tab(_)"),
    
    bdoc("Resize the frame."),
    mdrag("Button1@border", "WFrame.p_resize(_)"),
    mdrag(META.."Button3", "WFrame.p_resize(_)"),
    
    bdoc("Move the frame."),
    mdrag(META.."Button1", "WFrame.p_move(_)"),
    
    bdoc("Move objects between frames by dragging and dropping the tab."),
    mdrag("Button1@tab", "WFrame.p_tabdrag(_)"),
    mdrag("Button2@tab", "WFrame.p_tabdrag(_)"),
           
})

-- Frames for transient windows ignore this bindmap

defbindings("WFrame.toplevel", {
    bdoc("Attach tagged objects to this frame."),    
    kpress(META.."A", "ioncore.tagged_attach(_)"),

    bdoc("Query for a client window to attach."),
    kpress(META.."Shift+A", "mod_query.query_attachclient(_)"),

    bdoc("Switch to next/previous object within the frame."),
    kpress(META.."Next", "WFrame.switch_next(_)"),
    kpress(META.."Prior", "WFrame.switch_prev(_)"),

    bdoc("Move current object within the frame left/right."),
    kpress(META.."comma", "WFrame.dec_index(_, _sub)", "_sub:non-nil"),
    kpress(META.."period", "WFrame.inc_index(_, _sub)", "_sub:non-nil"),
    
    submap(META.."K", {
        -- Display tab numbers when modifiers are released
        submap_wait("ioncore.tabnum.show(_)"),
        
        bdoc("Switch to n:th object within the frame."),
        kpress("1", "WFrame.switch_nth(_, 0)"),
        kpress("2", "WFrame.switch_nth(_, 1)"),
        kpress("3", "WFrame.switch_nth(_, 2)"),
        kpress("4", "WFrame.switch_nth(_, 3)"),
        kpress("5", "WFrame.switch_nth(_, 4)"),
        kpress("6", "WFrame.switch_nth(_, 5)"),
        kpress("7", "WFrame.switch_nth(_, 6)"),
        kpress("8", "WFrame.switch_nth(_, 7)"),
        kpress("9", "WFrame.switch_nth(_, 8)"),
        kpress("0", "WFrame.switch_nth(_, 9)"),
               
        bdoc("Maximize the frame horizontally/vertically."),
        kpress("H", "WFrame.maximize_horiz(_)"),
        kpress("V", "WFrame.maximize_vert(_)"),
    }),
})

-- Bindings for floating frames.

defbindings("WFrame.floating", {
    bdoc("Toggle shade mode"),
    mdblclick("Button1@tab", "WFrame.set_shaded(_, 'toggle')"),
    
    bdoc("Raise the frame."),
    mpress("Button1@tab", "WRegion.rqorder(_, 'front')"),
    mpress("Button1@border", "WRegion.rqorder(_, 'front')"),
    mclick(META.."Button1", "WRegion.rqorder(_, 'front')"),
    
    bdoc("Lower the frame."),
    mclick(META.."Button3", "WRegion.rqorder(_, 'back')"),
    
    bdoc("Move the frame."),
    mdrag("Button1@tab", "WFrame.p_move(_)"),
})


-- WMoveresMode context bindings
-- 
-- These bindings are available keyboard move/resize mode. The mode
-- is activated on frames with the command begin_kbresize (bound to
-- META..{Arrow Key} above

defbindings("WMoveresMode", {
    bdoc("Cancel the resize mode."),
    kpress("AnyModifier+Escape","WMoveresMode.cancel(_)"),

    bdoc("End the resize mode."),
    kpress("AnyModifier+Return","WMoveresMode.finish(_)"),

    bdoc("Shrink in specified direction."),
    kpress("Shift+Left",  "WMoveresMode.resize(_,-1, 0, 0, 0)"),
    kpress("Shift+Right", "WMoveresMode.resize(_, 0,-1, 0, 0)"),
    kpress("Shift+Up",    "WMoveresMode.resize(_, 0, 0,-1, 0)"),
    kpress("Shift+Down",  "WMoveresMode.resize(_, 0, 0, 0,-1)"),
    
    bdoc("Move in specified direction."),
    kpress(META.."Left",  "WMoveresMode.move(_,-1, 0)"),
    kpress(META.."Right", "WMoveresMode.move(_, 1, 0)"),
    kpress(META.."Up",    "WMoveresMode.move(_, 0,-1)"),
    kpress(META.."Down",  "WMoveresMode.move(_, 0, 1)"),
})


