FROM elixir:1.13.4-alpine as build

ENV MIX_ENV=prod
ENV AKKOMA_VERSION=v3.2.1

WORKDIR /akkoma

RUN apk add git gcc g++ musl-dev make cmake file-dev &&\
    git clone -b develop https://akkoma.dev/AkkomaGang/akkoma.git /akkoma &&\
    git checkout ${PLEROMA_VER} &&\
	echo "import Config" > config/prod.secret.exs &&\
	mix local.hex --force &&\
	mix local.rebar --force &&\
	mix deps.get --only prod &&\
	mkdir release &&\
	mix release --path release

FROM alpine:3.16

ARG HOME=/opt/akkoma
ARG DATA=/var/lib/akkoma

RUN apk update &&\
	apk add exiftool ffmpeg imagemagick libmagic ncurses postgresql-client &&\
	adduser --system --shell /bin/false --home ${HOME} akkoma &&\
	mkdir -p ${DATA}/uploads &&\
	mkdir -p ${DATA}/static &&\
	chown -R akkoma ${DATA} &&\
	mkdir -p /etc/akkoma &&\
	chown -R akkoma /etc/akkoma

USER akkoma

COPY --from=build --chown=akkoma:0 /akkoma/release ${HOME}

COPY ./config.exs /etc/akkoma/config.exs
COPY ./docker-entrypoint.sh ${HOME}

EXPOSE 4000

ENTRYPOINT ["/opt/akkoma/docker-entrypoint.sh"]