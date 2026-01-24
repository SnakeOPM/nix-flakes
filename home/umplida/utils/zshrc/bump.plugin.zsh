bump () {
    local verFile=${ZSH_BUMP_VERSION_FILE_NAME:-.version}

    if [ "$1" = "init" ];  then
        if [ ! -f "./${verFile}" ]; then
            echo "v0.0.0" > ./${verFile};
            return 0
        else
            return 0
        fi
    fi

    if [ ! -f "./${verFile}" ]; then
        echo "Version file not found."
        return 1
    fi

    case "$1" in
        "");&
        "patch")
            version=$(cat ${verFile} | awk '/^v([0-9.]+)/{ lv=$1; sub("v","",lv);  split(lv, varr, "."); varr[3]++; print "v" varr[1] "." varr[2] "." varr[3]; }')
        ;;
        "minor");&
        "m")
            version=$(cat ${verFile} | awk '/^v([0-9.]+)/{ lv=$1; sub("v","",lv);  split(lv, varr, "."); varr[2]++; print "v" varr[1] "." varr[2] ".0"; }')
        ;;
        "major");&
        "M")
            version=$(cat ${verFile} | awk '/^v([0-9.]+)/{ lv=$1; sub("v","",lv);  split(lv, varr, "."); varr[1]++; print "v" varr[1] ".0.0"; }')
        ;;
        *)
            echo "Unknown action"
            return 1
         ;;
    esac

    echo ${version} > ${verFile}
    
    if [ -d .git ]; then
        git add ${verFile}
        git commit -m "Release ${version}"
        git tag ${version}
    fi
}

