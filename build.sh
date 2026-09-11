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

source ./axiom/tools/odin_env.sh
odin_options=(-debug)
if [[ "${1:-debug}" == release ]]; then
    odin_options=(-o:speed)
fi

mkdir -p build
"$odin_command" build src/main.odin -file "${odin_options[@]}" \
    "-out:build/axiom_example_project${executable_suffix}"
