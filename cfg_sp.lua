--
-- Ion mod_sp configuration file
--

defbindings("WScreen", {
    bdoc("Toggle scratchpad."),
    kpress(META.."Q", "mod_sp.set_shown_on(_, 'toggle')"),
})

