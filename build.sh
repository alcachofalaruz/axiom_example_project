#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
git submodule update --init --recursive
./axiom/build.sh "$@"

executable_suffix=""
case "$(uname -s)" in
MINGW*|MSYS*|CYGWIN*) executable_suffix=.exe ;;
esac

"./axiom/build/axiom-metagen${executable_suffix}" src src game
