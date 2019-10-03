FROM kkodc/geobase:builder as builder

FROM ubuntu:18.04

RUN apt-get update -y \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --fix-missing --no-install-recommends \
  python3 python3-dev python3-pip python3-venv \
  && rm -rf /var/lib/apt/lists/*

# GDAL/GEOS/PROJ dependencies
RUN apt-get update -y \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --fix-missing --no-install-recommends \
  libopenjp2-7 \
  libzstd1 \
  liblzma5 \
  libcurl4 \
  libssl1.1 \
  libpq5 \
  libxml2 libexpat1 libxerces-c3.2 \
  libnetcdf-c++4 netcdf-bin \
  libhdf4-0-alt libhdf5-100 libhdf5-cpp-100 libwebp6 \
  libpcre3 \
  libkmlbase1 libkmlconvenience1 libkmldom1 libkmlengine1 libkmlregionator1 libkmlxsd1 \
  libyaml-0-2 \
  libatlas3-base \
  libgfortran4 \
  && rm -rf /var/lib/apt/lists/*

# TODO: we don't really need .deb files polluting this docker image, but alternatives are annoying to use
#  A. Run http server that would serve *deb packages and fetch from there
#  B. Copy installed files instead of .deb (need to know which ones)
#  C. Use experimental docker features: `RUN --mount=type=cache,ro,from=builder,source=/opt,target=/opt ...`
COPY --from=builder /opt/*deb /opt/
RUN echo "Installing geo libs" \
  && dpkg -i /opt/libgeos*deb \
  && dpkg -i /opt/libgdal*deb \
  && echo "Done"