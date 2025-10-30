use std/config

$env.config.show_banner = false

$env.config.highlight_resolved_externals = true;

# $env.config.color_config = (config dark-theme | merge {
#     nothing: light_gray
#     shape_external: red
#     shape_external_resolved: cyan
#     shape_externalarg: green
# })

# $env.config.datetime_format = {
#     normal: '%a %F %T%.f %Z'
#     table: '%F %T%.f %z'
# }

# $env.config.explore = {
#     status_bar_background: { fg: "#1D1F21", bg: "#C4C9C6" },
#     command_bar_text: { fg: "#C4C9C6" },
#     highlight: { fg: "black", bg: "yellow" },
#     status: {
#         error: { fg: "white", bg: "red" },
#         warn: {}
#         info: {}
#     },
#     selected_cell: { bg: light_blue },
# }

# $env.config.table.trim = {
#     methodology: truncating
#     truncating_suffix: "…"
# }

# $env.config.menus ++= do {
#     let style = {
#         text: default
#         description_text: yellow
#         selected_text: { attr: bu }
#         match_text: { attr: u }
#         selected_match_text: { attr: bu }
#     }
#     let completion_menu = {
#         name: completion_menu
#         only_buffer_difference: false
#         marker: "| "
#         type: {
#             layout: columnar
#             columns: 4
#             col_width: 20
#             col_padding: 2
#         }
#         style: $style
#     }
#     let history_menu = {
#         name: history_menu
#         only_buffer_difference: true
#         marker: "? "
#         type: {
#             layout: list
#             page_size: 10
#         }
#         style: $style
#     }
#     let help_menu = {
#         name: help_menu
#         only_buffer_difference: true
#         marker: "? "
#         type: {
#             layout: description
#             columns: 4
#             col_width: 20
#             col_padding: 2
#             selection_rows: 4
#             description_rows: 20
#         }
#         style: $style
#     }
#     [$completion_menu $history_menu $help_menu]
# }



## aliases and alias-like scripts

## ls
def l [...paths: glob] {
  match $paths {
    [] => (ls -a | sort-by type name | select name type)
    _ => (ls -a ...$paths | sort-by type name | select name type)
  }
}

def ll [...paths: glob] {
  match $paths {
    [] => (ls -al | sort-by type name | select name type target size modified user group mode)
    _ => (ls -al ...$paths | sort-by type name | select name type target size modified user group mode)
  }
}

## tree (eza)
# keep-sorted start
alias t = eza --tree --group-directories-first
alias tt = t --long --header --group --binary --time-style=iso
# keep-sorted end


## git
# keep-sorted start
alias gaa = git add .
alias gc = git commit
alias gca = git commit --amend
alias gch = git checkout
alias gd = git diff
alias glog = git log --all --oneline --graph
alias gr = git review
alias gs = git status
# keep-sorted end

## jj
# keep-sorted start
alias jjgf = jj git fetch
alias jjgp = jj git push
# keep-sorted end

def --wrapped jjgu [revision?: string, ...rest] {
  match $revision {
    null => (jj gerrit upload -r @ ...$rest)
    _ => (jj gerrit upload -r $revision ...$rest)
  }
}

## nix
# keep-sorted start
alias nd = nix develop
alias ns = nix shell
# keep-sorted end

def --wrapped ds [name: string, ...rest] {
  nix develop $"c#shell-($name)" -c nu ...$rest
}

## mpv
alias kpv = mpv --vo=kitty

## cargo
alias clippy-watch = cargo watch -q -s "clear; cargo clippy --all-targets"

## sops
alias homesops = SOPS_AGE_KEY=(age -d ~/Keys/homeops.age) sops
