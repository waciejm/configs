# ========= ls ==========

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

# ========= tree (eza) ==========
# keep-sorted start

alias t = eza --tree --group-directories-first
alias tt = t --long --header --group --binary --time-style=iso

# keep-sorted end

# ========= git ==========
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

# ========= jj ==========
# keep-sorted start

alias jjgd = jj-gerrit-download
alias jjgf = jj git fetch
alias jjgp = jj git push

# keep-sorted end

def --wrapped jjgu [revision?: string, ...rest] {
  match $revision {
    null => (jj gerrit upload -r @ ...$rest)
    _ => (jj gerrit upload -r $revision ...$rest)
  }
}

# ========= nix ==========
# keep-sorted start

alias nd = nix develop -c $env.SHELL
alias ns = nix shell

# keep-sorted end

def --wrapped ds [name: string, ...rest] {
  nix develop $"c#shell-($name)" -c nu ...$rest
}

# ========= mpv ==========
# keep-sorted start

alias kpv = mpv --vo=kitty

# keep-sorted end

# ========= cargo ==========
# keep-sorted start

alias clippy-watch = cargo watch -q -s "clear; cargo clippy --all-targets"

# keep-sorted end

# ========= sops ==========
# keep-sorted start

alias homesops = SOPS_AGE_KEY=(age -d ~/Keys/homeops.age) sops

# keep-sorted end
