# `env`

Netbeheer Nederland environment for information modeling and generating documentation and schemas.

## Usage

> [!warning]
> All ways of running the container assume the container being run from a Bash shell. Linux and macOS installations typically have Bash installed, but Windows does not. Windows users are advised to use WSL to make sure their environment works with these instructions as well.

### Running

Use the `run.sh` script to instantiate a container. It runs the container for you while taking care of:

* mounting the project working directory in the container in the `/project` directory
* mount the host user's SSH key directory in the container
* mapping the host user to the target container environment (UID, GID and name)
* setting the Git user name and e-mail as globally (in the `--global` sense) configured in the host environment

Running the script is as simple as:

```sh
$ ./run.sh
```

This will assume the current working directory is the project directory, which it mounts to `/project`.

If a different directory than the working directory should serve as the project directory, pass it as an argument:

```sh
$ ./run.sh ~/projects/my-data-product
```

## Developing

### Building

Simply run the `build.sh` script:

```sh
$ ./build.sh
```
