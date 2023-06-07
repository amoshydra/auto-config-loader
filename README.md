# Auto Config Loader

## Project setup

We uses docker to test and debug profile.
This volume mount is setup `./scripts:/root/scripts`, allowing you to test the scripts in docker.

### Start
```sh
docker compose up -d
```

### Test
```sh
docker exec -it computer bash
```

### Destroy
```sh
docker compose down
```

## Running auto config loader
A test profile is available for testing a `/scripts/test/profile`. Running the install command with a `--debug` flat will inject the source script command into the test profile.

```sh
./scripts/_install.sh --debug
```

Run this command to uninstall

```sh
./scripts/_uninstall.sh --debug
```

## Additional reading
- `/etc/profile.d/` is not available on MacOS 10.15 or above https://github.com/particledecay/galaxy-asdf/issues/1
- https://askubuntu.com/a/476435
- `/etc/profile` does not work on `zsh` on MacOS
  > This implys that `/etc/profile` is *always read* by `zsh` at login - I haven't got any experience with the Arch Linux project; the wiki may be correct for that distribution, but it is *not* generally correct. The information **is** incorrect compared to the zsh manual pages, and doesn't seem to apply to zsh on OS X (paths in `$PATH` set in `/etc/profile` do not make it to my zsh sessions).
  > -- https://stackoverflow.com/questions/10574684/where-to-place-path-variable-assertions-in-zsh
- differences between interactive and non-inteeractive shell. We only need to care about interactive shell. https://unix.stackexchange.com/questions/38175/difference-between-login-shell-and-non-login-shell
- This chart illustrate how the different shell source env https://unix.stackexchange.com/a/541092