
##
## google.kak
##

evaluate-commands %sh{
    ## default bg black
    base00='rgb:1d1f21'
    base_black='rgb:1d1f21'
    ## lighter bg black
    base01='rgb:282a2e'
    ## selection bg black
    base02='rgb:373b41'
    ## comments black
    base03='rgb:969896'
    ## dark fg grey
    base04='rgb:b4b7b4'
    ## default fg grey
    base05='rgb:c5c8c6'
    ## light fg grey
    base06='rgb:e0e0e0'
    ## light bg white
    base07='rgb:ffffff'
    base_white='rgb:ffffff'
    ## red
    base08='rgb:CC342B'
    base_red='rgb:CC342B'
    ## orange
    base09='rgb:F96A38'
    base_orange='rgb:F96A38'
    ## yellow
    base0A='rgb:FBA922'
    base_yellow='rgb:FBA922'
    ## green
    base0B='rgb:198844'
    base_green='rgb:198844'
    ## cyan
    base0C='rgb:3971ED'
    base_cyan='rgb:3971ED'
    ## blue
    base0D='rgb:3971ED'
    base_blue='rgb:3971ED'
    ## purple
    base0E='rgb:A36AC7'
    base_purple='rgb:A36AC7'
    ## brown
    base0F='rgb:3971ED'
    base_brown='rgb:3971ED'

    ## code
    echo "
        face global value ${base09}+b
        face global type ${base0A}
        face global identifier ${base08}
        face global string ${base0B}
        face global error ${base05},${base0B}
        face global keyword ${base0E}+b
        face global operator ${base05}
        face global attribute ${base09}
        face global comment ${base03}
        face global meta ${base0A}
    "

    ## markup
    echo "
        face global title ${base0D}
        face global header ${base0D}
        face global bold ${base0A}
        face global italic ${base09}
        face global mono ${base0B}
        face global block ${base09}
        face global link ${base0D}
        face global bullet ${base0B}
        face global list ${base08}
    "

    ## builtin
    echo "
        face global Default ${base05},${base_black}
        face global PrimarySelection ${base_white},${base_blue}
        face global SecondarySelection ${base05},${base_blue}
        face global PrimaryCursor ${base_black},${base_white}
        face global SecondaryCursor ${base_black},${base05}
        face global LineNumbers ${base05},${base01}
        face global LineNumberCursor ${base05},rgb:282828+b
        face global MenuForeground ${base_white},${base_blue}
        face global MenuBackground ${base_blue},${base01}
        face global MenuInfo ${base_blue}
        face global Information ${base00},${base_blue}
        face global Error ${base01},${base_red}
        face global StatusLine ${base06},${base01}
        face global StatusLineMode ${base_yellow}
        face global StatusLineInfo ${base_blue}
        face global StatusLineValue ${base_green}
        face global StatusCursor ${base02},${base_blue}
        face global Prompt ${base_yellow},${base_black}
        face global MatchingChar ${base_blue},${base00}+b
        face global BufferPadding ${base_blue},${base01}
    "
}
