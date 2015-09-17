function fish_prompt --description 'Write out the prompt'
	# Save the return status of the previous command
    set stat $status

    # Just calculate these once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end
    if not set -q __fish_color_status
        set -g __fish_color_status (set_color red)
    end
    if not set -q __fish_color_remote_commits
        set -g __fish_color_remote_commits (set_color yellow)
    end
    if not set -q user_home_prefix
        set -g user_home_prefix (echo ~ | sed 's/\//\\\\&/g')
    end

    switch $USER
    case root toor
        if not set -q __fish_prompt_cwd
            if set -q fish_color_cwd_root
                set __fish_prompt_cwd (set_color $fish_color_cwd_root)
            else
                set __fish_prompt_cwd (set_color $fish_color_cwd)
            end
        end

        printf '%s%s%s# ' "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal"

    case '*'
        if not set -q __fish_prompt_cwd
            set -g __fish_prompt_cwd (set_color $fish_color_cwd)
        end

        set directory (echo $PWD | sed 's/^'(echo ~ | sed 's/\//\\\\&/g')'/~/')

        set git_status (git status --porcelain 2>/dev/null)
        if test $status -eq 0
            set print_git 0
            # Check if we have any output at all from git status
            if not test "$git_status" = ''
                # If we do, check that it's not merely about untracked files
                set file_changes (echo "$git_status" | grep -v --max-count 1 '^??')
                if test "$file_changes" = ''
                    set git_status ''
                else
                    set git_status '*'
                end
            end
            set git_branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
            if test $status -eq 0
                if test "$git_branch" = "HEAD"
                    set git_branch (git rev-parse --short HEAD)
                else
                    # Check how many commits ahead the corresponding origin branch is
                    set local_commits (git log --format='format:.' origin/"$git_branch"..  2>/dev/null)
                    if test $status -eq 0
                        set num_future_local_commits (echo -n $local_commits | awk 'END {print NR;}')
                        if test $num_future_local_commits -eq 0
                            set -e num_future_local_commits
                        else
                            set num_future_local_commits ".$num_future_local_commits"
                        end
                        set num_future_remote_commits (git log --format='format:.' ..origin/"$git_branch" | awk 'END {print NR;}')
                        if test $num_future_remote_commits -eq 0
                            set -e num_future_remote_commits
                        else
                            set num_future_remote_commits "ˆ$num_future_remote_commits"
                        end
                    end
                end
                set git_branch " $git_branch"
            else
                # It's probably a newly created repository
                set git_branch ' (initial commit)'
                set git_status '*'
            end
        else
            set -e print_git
        end

        if test $stat -gt 0
            set stat_str ' '$stat
        else
            set stat_str ''
        end

        if not set -q CMD_DURATION
            set cmd_duration 0
        else
            set cmd_duration $CMD_DURATION
        end

        if test $cmd_duration -gt 500
            set duration (python -c "print round(float($cmd_duration) / 1000, 3), \"sec\"")
        else
            set duration ''
        end

        ### Printing

        printf '%s' "$directory"

        if set -q print_git
            printf '%s%s%s%s%s%s%s' \
                "$__fish_prompt_cwd" "$git_branch" \
                "$__fish_color_status" "$git_status" \
                "$__fish_prompt_cwd" "$num_future_local_commits" \
                "$__fish_color_remote_commits" "$num_future_remote_commits" \
                "$__fish_prompt_normal"
        end
            
        printf '%s%s%s %s\f\r$ ' \
            "$__fish_color_status" "$stat_str" "$__fish_prompt_normal" \
            "$duration"
    end
end
