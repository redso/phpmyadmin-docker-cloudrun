## Run phpmyadmin with Google Cloud Run

### Why

Seems Google Cloud Run has error when running with operator `<` in [this line](https://github.com/phpmyadmin/docker/blob/master/docker-entrypoint.sh#L7) in docker-entrypoint.sh, cause the container cannot start up normally.

```sh
\$cfg['blowfish_secret'] = '$(tr -dc 'a-zA-Z0-9~!@#$%^&*_()+}{?></";.,[]=-' < /dev/urandom | fold -w 32 | head -n 1)';
```

### How to fix

This script change the code from `tr -dc 'a-zA-Z0-9~!@#$%^&*_()+}{?></";.,[]=-' < /dev/urandom` to `head -c 10000 /dev/urandom | tr -dc 'a-zA-Z0-9~!@#$%^&*_()+}{?></";.,[]=-'`

### How to use this

1. Manually setup Google Container Registry / Artifact Registry.
2. Change the params in [Makefile](Makefile) and then run `make push`. It will build and push to the registry.
3. Use `REGISTRY_PATH` output in console as the cloud run image.

| params | description |
|--|--|
| PROJECT_NAME | GCP Project Name |
| REGISTRY | Google Container Registry / Artifact Registry |
| REPOSITORY | Google Artifact Registry Repository |
| VERSION | Phpmyadmin Version |
