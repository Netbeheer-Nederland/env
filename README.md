# `env`

Netbeheer Nederland environment for information modeling and generating documentation and schemas.

## Usage

> [!warning]
> All ways of running the container assume the container being run from a Bash shell. Linux and macOS installations typically have Bash installed, but Windows does not. Windows users are advised to use WSL to make sure their environment works with these instructions as well.

### Running

Use the `run.sh` script to instantiate a container. It runs the container for you while taking care of:

* mounting the current working directory in the container in the `/project` directory
* mount the host user's home directory in the container - which particularly ensures that SSH keys are present
* mapping the host user to the target container environment (UID, GID and name)
* setting the Git user name and e-mail as globally (in the `--global` sense) configured in the host environment

Running the script is as simple as:

```sh
$ ./run.sh
```

## Developing

### Building

Simply run the `build.sh` script:

```sh
$ ./build.sh
```
