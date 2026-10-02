hook -group lsp-filetype-gdscript global BufSetOption filetype=gdscript %{
    set-option buffer lsp_servers %{
        [godot-lsp]
        command = "socat"
        args = ["-", "TCP4-CONNECT:127.0.0.1:6005"]
        filetypes = ["gdscript"]
        root_globs = ["project.godot"]
    }
}
