### Apollo is a script to setup a Raspberry pi as a server for developement running ubuntu 22.04. Basic minimal setup.

- it may work on mac os x; I don't see the use case of it.

### Gettting started
...
NOTE: This creates a symbolic between this project and /usr/local/bin dir

```bash

bash install.sh
# to remove? re-run the script and delete this project.

```

in ```default.yaml``` file, follow this format

```yaml

development:  # This is start of development and meun.

development commands:
  - commit and push: bash scripts/development.sh commit push
  - kill process: bash scripts/development.sh kill-process
  - new project:
  - setup server:
  - help:



new project:  # for new projects
new project commands:
  - React.js: npx create-react-app <project-directory>
  - Next.js: npx create-next-app@latest




setup server:  # for server setup
setup server command:
  - developement tools:
  - disable sudo requirements: bash scripts/server.sh prevent_sudo


developement tools:  # for server setup
developement tools commands:
  - install containers :
  - install all: bash scripts/server.sh install_all
  - individual install:


individual install:  # for server setup
individual install command:
  - docker: docker
  - python: conda
  - golang: go
  - node: node
  - npm:  npm
  - java: javac
  - Rust: rustc


install containers:
install containers commands:
  - portainer: https://github.com/portainer/portainer
  - docker: https://www.docker.com || _ https://download.docker.com/linux
  - jellyfin: https://github.com/jellyfin/jellyfin
  - cockpit-project:  https://cockpit-project.org
  - libreddit: https://github.com/spikecodes/libreddit



help:  # for help commands
help commands:
  - remove scripts: bash install.sh
  - All access chmod -R a+rwx * this directory: bash scripts/development.sh permission

```






