
###  ~~Workflow~~ Apollo is a script to setup a Raspberry pi as a server for developement running ubuntu 22.04. Basic minimal setup.

- it may work on mac os x; I don't see the use case of it

##### For web developement docker images will be used. Setting up ngnix, apache, maven etc... usually has ports conflicts, and it is a pain to figure out which program is using which ports.

- all scripts and programs are runing ubuntu 22.04 LTS on arm64

### Gettting started
...
NOTE: This creates a symbolic between this project and /usr/local/bin dir

```bash

bash install.sh
# to remove? re-run the script and delete this project.

```


- list of installations
    - python _ https://github.com/conda-forge/miniforge/
    - golang
    - node - (node is .disabled by default)
    - npm - (npm is .disabled by default)
    - java - (java is .disable by default)
    - Rust - (rust is .disable by default)
    - portainer _ https://github.com/portainer/portainer
    - docker _ https://www.docker.com || _ https://download.docker.com/linux
    - jellyfin _ https://github.com/jellyfin/jellyfin
    - cockpit-project _ https://cockpit-project.org
    - docpht _ https://github.com/docpht/docpht
    - hapttic _ https://github.com/jsoendermann/hapttic
    - immich _ https://github.com/alextran1502/immich
    - snikket-server _ https://github.com/snikket-im/snikket-server
    - libreddit _ https://github.com/spikecodes/libreddit
    - javascript refrences https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference



Release notes:




- v0.0.2
    - updating menu to use https://github.com/lpenz/tuzue
    - using /usr/local/bin for executables
    - Change name to Apollo.

- v0.0.1
    - using makefile(s)
    - fix some issues with toml and javascript - can't return value from toml
    - installing the important stuff first.
    - Added showcase gif


- v0.0.0
    - Added commit project
    - Added github support
    - Add start django server
    - Added Docker script
    - Added Portainer
    - Add golang





