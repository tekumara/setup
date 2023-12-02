dinstall() {
    local url=$1
    local dest=$2
    local sha256=$3

    { [[ -z "$url" ]] || [[ -z "$dest" ]] ;} && {
        echo "Usage: $0 url dest [sha256]"
        return 42
    }

    # check sha of any existing binary first, and skip if already installed
    # if the url is an archive, this will always fail and we'll download
    if ! [[ -f "$dest" ]] || [[ -z "$sha256" ]] || { ! echo "$sha256  $dest"  | shasum -s --check ;} then
        download=/tmp/$(basename "$url")
        echo "Downloading $url"
        curl -fsSLO --output-dir /tmp "$url"
        if [[ -n "$sha256" ]]; then
            echo "$sha256  $download"  | shasum --check
        else
            shasum "$download"
        fi

        case "$download" in
            # if download is a tar archive, then assume $(basename "$dest") is the desired file within the archive
            *.tar.gz) tar -zxf "$download" -C /tmp && file=/tmp/$(basename "$dest") ;;
            *.zip) unzip "$download" -d /tmp && file=/tmp/$(basename "$dest") ;;
            *)        file=$download ;;
        esac

        echo "Installing $file -> $dest"
        install "$file" "$dest"
    fi
}
