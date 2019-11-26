# Custom Jenkins

Example of how to leverage [Jenkins docker](https://github.com/jenkinsci/docker/blob/master/README.md) and [configuration-as-code-plugin](https://github.com/jenkinsci/configuration-as-code-plugin) to run a fully configured Jenkins

## Usage

Generate jobs for bitbucket projects:
```bash
./generate_jobs.sh
```

Build the image:
```bash
./build.sh
```

Run the image:
```bash
./run.sh
```