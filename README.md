# gh

Just a small alpine based container with `curl` and `gh` cli installed.

## Usage

```bash
docker run -e GITHUB_TOKEN=xxx -v $(pwd):$(pwd) -w $(pwd) jhagestedt/gh
```
