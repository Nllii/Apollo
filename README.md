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

development:  # for development
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
  - install_all: True


help:  # for help commands
help commands:
  - remove scripts:
  - give all access to folder: bash scripts/development.sh

```






