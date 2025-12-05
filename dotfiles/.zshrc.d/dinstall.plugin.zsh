sha() {
    if [[ "$(uname)" == "Darwin" ]]; then
        shasum "$@"
    else
        sha256sum "$@"
    fi
}

dinstall() {
    # download, check sha and install an archived binary from a URL
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
    if ! [[ -f "$dest" ]] || [[ -z "$sha256" ]] || { ! echo "$sha256  $dest"  | sha --check &>/dev/null ;} then
        download="${tmpdir}"/$(basename "$url")
        echo "Downloading $url"
        curl -fsSLo "$download" "$url"
        if [[ -n "$sha256" ]]; then
            echo "$sha256  $download" | sha --check
        else
            sha "$download"
        fi

        dest_basename=$(basename "$dest")
        case "$download" in
            # if download is a tar archive, then assume $(basename "$dest") is the desired file within the archive
            # find will locate the extracted file in subdirs too (eg: "${tmpdir}"/gh_2.40.1_linux_amd64/bin/gh)
            *.tar.gz)
                tar -zxf "$download" -C "${tmpdir}/"
                file=$(find "${tmpdir}" -name "$dest_basename" -type f | head -n1)
                ;;
            *.zip)
                unzip "$download" -d "${tmpdir}/"
                file=$(find "${tmpdir}" -name "$dest_basename" -type f | head -n1)
                ;;
            *)  file=$download ;;
        esac

        echo "Installing $file -> $dest"
        install "$file" "$dest"
    fi
    rm -rf "$tmpdir"
}
