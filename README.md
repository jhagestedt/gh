# gh

Just a small alpine based container with `git`, `curl`, `httpie`, `gh` and `ghapp` installed.

## Usage

The container is published at [Dockerhub](https://hub.docker.com/repository/docker/jhagestedt/gh).

```bash
docker run --rm -v "$(pwd):$(pwd)" -w "$(pwd)" -e GITHUB_TOKEN jhagestedt/gh version
```
