#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/hairyhenderson/gomplate"
TOOL_NAME="gomplate"
TOOL_TEST="gomplate -v"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if gomplate is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
	# Change this function if gomplate has other means of determining installable versions.
	list_github_tags
}
get_filename() {
	local binary_name="$1"
	local platform="$2"
	local arch_name="$3"

	echo "${binary_name}_${platform}-${arch_name}"
}

download_release() {
	local version destination url platform arch_name filename
	version="$1"
	destination="$2"

	platform="$(get_platform)"
	arch_name="$(get_arch)"

	filename="$(get_filename $TOOL_NAME "${platform}" "${arch_name}")"

	url="$GH_REPO/releases/download/v${version#v}/${filename}"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$destination" -C - "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		# TODO: Assert gomplate executable exists.
		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
get_platform() {
	uname | tr '[:upper:]' '[:lower:]'
}

get_arch() {
	local arch
	if [ "$(uname -m)" = "x86_64" ]; then
		arch="amd64"
	elif [ "$(uname -m)" = "aarch64" ]; then
		arch="arm"
	elif [ "$(uname -m)" = "arm64" ]; then
		arch="arm64"
	else
		arch="386"
	fi

	echo "${arch}"
}
