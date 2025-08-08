dinstall() {
    local url=$1
    local dest=$2
    local sha256=$3
    local tmpdir
    tmpdir="$(mktemp -d)"

    { [[ -z "$url" ]] || [[ -z "$dest" ]] ;} && {
        echo "Usage: $0 url dest [sha256]"
        return 42
    }

    # check sha of any existing binary first, and skip if already installed
    # if the url is an archive, this will always fail and we'll download
    if ! [[ -f "$dest" ]] || [[ -z "$sha256" ]] || { ! echo "$sha256  $dest"  | shasum -s --check ;} then
        download="${tmpdir}"/$(basename "$url")
        echo "Downloading $url"
        curl -fsSLo "$download" "$url"
        if [[ -n "$sha256" ]]; then
            echo "$sha256  $download"  | shasum --check
        else
            shasum "$download"
        fi

        case "$download" in
            # if download is a tar archive, then assume $(basename "$dest") is the desired file within the archive
            # ** will find the extracted file in subdirs too (eg: "${tmpdir}"/gh_2.40.1_linux_amd64/bin/gh) - for globbing
            # to work this needs to be an array, hence the extra ( )
            *.tar.gz) tar -zxf "$download" -C "${tmpdir}/" && file=("${tmpdir}"/**/$(basename "$dest")) ;;
            *.zip) unzip "$download" -d "${tmpdir}/" && file=("${tmpdir}"/**/$(basename "$dest")) ;;
            *)        file=$download ;;
        esac

        echo "Installing $file -> $dest"
        install $file "$dest"
    fi
}
