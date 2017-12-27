function ranger_cd
    set -l tempfile (mktemp -t ranger_choosedir.XXXXXX)
    /usr/local/bin/ranger --choosedir=$tempfile $argv
    if test -f $tempfile
        set -l newdir (cat $tempfile)
        if [ $newdir != (pwd) ];
            cd $newdir
        end
    end
    rm $tempfile
end
