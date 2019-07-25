set -eu

SDIR="$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd)"

cd "${SDIR}"

cc_name="${1:-kk-geo-build}"

mkdir -p _build
mkdir -p dl

docker rm "${cc_name}" 2> /dev/null || true

docker run \
       --name "${cc_name}" \
       -v $(pwd)/dl:/dl \
       -v $(pwd)/_build:/src \
       -ti kkodc/geo-builder
