FROM ubuntu:14.04

RUN apt-get update \
 && apt-get install -y --no-install-recommends wget ca-certificates \
 && wget -qO /usr/local/bin/go-github https://github.com/qnib/go-github/releases/download/0.2.2/go-github_0.2.2_Linux \
 && chmod +x /usr/local/bin/go-github \
 && echo "# init-plain: $(/usr/local/bin/go-github rLatestUrl --ghorg qnib --ghrepo init-plain --regex 'init-plain.tar' --limit 1)" \
 && wget -qO - "$(/usr/local/bin/go-github rLatestUrl --ghorg qnib --ghrepo init-plain --regex 'init-plain.tar' --limit 1)" |tar xf - --strip-components=1 -C / \
 && echo "# go-fisherman: $(/usr/local/bin/go-github rLatestUrl --ghorg qnib --ghrepo go-fisherman --regex '.*_x86' --limit 1)" \
 && wget -qO /usr/local/bin/go-fisherman "$(/usr/local/bin/go-github rLatestUrl --ghorg qnib --ghrepo go-fisherman --regex '.*_x86' --limit 1)" \
 && chmod +x /usr/local/bin/go-fisherman \
 && echo "Download: $(/usr/local/bin/go-github rLatestUrl --ghorg tianon --ghrepo gosu --regex 'gosu-amd64' --limit 1)" \
 && wget -qO /usr/local/bin/gosu $(/usr/local/bin/go-github rLatestUrl --ghorg tianon --ghrepo gosu --regex 'gosu-amd64' --limit 1) \
 && chmod +x /usr/local/bin/gosu \
 && rm -f /usr/local/bin/go-github \
 && apt-get purge -y wget ca-certificates libidn11 openssl \
 && rm -rf /var/lib/apt/lists/*
HEALTHCHECK --interval=5s --retries=5 --timeout=2s \
  CMD /usr/local/bin/healthcheck.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
