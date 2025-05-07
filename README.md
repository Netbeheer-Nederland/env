# `env`

Netbeheer Nederland environment for information modeling and generating documentation and schemas.

## Usage

### Using `run.sh`

```sh
$ ./run.sh
```

### Using `docker`

```sh
$ docker run -it --user "$(id -u):$(id -g)" -v ".:/project" nbnl-env /bin/bash
```

### Using `docker compose`

Make sure `compose.yml` is present in the working directory.

```sh
$ USER_ID=$(id -u) GROUP_ID=$(id -g) docker compose run nbnl-env
```
