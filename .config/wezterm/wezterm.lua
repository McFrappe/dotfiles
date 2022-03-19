local wezterm = require 'wezterm';
local Current_appearance = true;

local function scheme_for_appearance(appearance)
    if appearance:find("Dark") then
        return "Jellybeans"
    end

    return  "Github"
end

local function tabbarTheme()
    if Current_appearance then -- if its dark
        return "#282828";
    end

    return "#fafafa";
end

local function basename(input)
    return string.gsub(input, "(.*[/\\])(.*)", "%2")
end

wezterm.on("update-right-status", function(window)
    local window_dimensions = window:get_dimensions();

    if not window_dimensions.is_full_screen then
        window:set_right_status(wezterm.format({
            {Text=""},}));
    else
        local cmd = "plutil -extract AppleSelectedInputSources xml1 -o - ~/Library/Preferences/com.apple.HIToolbox.plist  | xmllint --xpath \"string(//string[2])\" -";
        local _, stdout, _ = wezterm.run_child_process({"sh", "-c", cmd});
        local date = wezterm.strftime("%a %b %-d %_I:%M:%S");
        local bat = ""
        for _, b in ipairs(wezterm.battery_info()) do
            bat = string.format("%.0f%%", b.state_of_charge * 100);
        end
        window:set_right_status(wezterm.format({
            {Text= stdout .. " " .. bat .. "  " .. date},}));
    end
end);

wezterm.on("window-config-reloaded", function(window)
    local overrides = window:get_config_overrides() or {};
    local appearance = window:get_appearance();
    local scheme = scheme_for_appearance(appearance);

    if overrides.color_scheme ~= scheme then
        Current_appearance = appearance:find("Dark")
        overrides.color_scheme = scheme;
        overrides.colors = {
            tab_bar = {
                background = tabbarTheme();
            }
        };
        window:set_config_overrides(overrides);
    end

end);

wezterm.on("format-tab-title", function(tab)
    local pane = tab.active_pane;
    local title = basename(pane.foreground_process_name);
    local bg_color;
    local fg_color;

    if Current_appearance then
        bg_color = "#282828"
        fg_color = "white"

        if tab.is_active then
            bg_color = "#61afef";
        end
    else
        bg_color = "#dcdfe4"
        fg_color = "black"
        if tab.is_active then
            bg_color = "#fafafa";
        end
    end

    return {
        {Background={Color=bg_color}},
        {Foreground={Color=fg_color}},
        {Text=" " .. title .. " "},
    };
end);

return {
    -- Window configuration
    freetype_load_target = "Light",
    pane_focus_follows_mouse = true,
    swallow_mouse_click_on_pane_focus = false,
    adjust_window_size_when_changing_font_size = false,
    window_background_opacity = 0.95,
    -- text_background_opacity = 0.5,
    use_fancy_tab_bar = false,
    initial_cols = 80,
    initial_rows = 24,
    exit_behavior = "Close",
    colors = {
        tab_bar = {
            background = tabbarTheme(),
        },
    },

    -- Theming, fonts and colors
    font = wezterm.font_with_fallback({
        "Monaco", -- The main font I want to use
        "Menlo", -- This has the check mark and cross symbols
        "Apple Color Emoji" -- I prefer apple emoji to google emoji
    }, {weight="Medium"}),
    font_size = 11,
    bold_brightness_ansi_colors = true,
    -- misc
    launch_menu = {
        {
            args = {"htop"},
        },
        {
            label = "Bash Shell",
            args = {"bash"},
        },
    },
    keys = {
        {key="-", mods="SUPER", action="DecreaseFontSize"},
        {key="+", mods="SUPER", action="IncreaseFontSize"},
        {key="0", mods="SUPER", action="ResetFontSize"},
    },
    mouse_bindings = {
        -- Ctrl-click will open the link under the mouse cursor
        {
            event={Up={streak=1, button="Left"}},
            mods="CTRL",
            action="OpenLinkAtMouseCursor",
        },
    },
};
