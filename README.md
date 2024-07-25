# A PHP7.4 Docker with Xdebug

This repo contains everything required for running PHP7.4 in docker with Xdebug. Refer <https://dev.to/jackmiras/xdebug-in-vscode-with-docker-379l> for my source of xdebug setup.

## Xdebug file Explaination

- `zend_extension=xdebug.so` - Enable the extension
- `xdebug.mode=develop,coverage,debug,profile` - Modes, can be set to only debug
- `xdebug.start_with_request=yes` - Start the xdebug as soon as request is received, don't wait for debugger breakpoints.
- `xdebug.remote_enable=1` - Enable remote debugging, required with docker with VS Code as of now.
- `xdebug.client_host=host.docker.internal` - Host where the debugger is listening, The host entry is added by docker-compose.yml
- `xdebug.client_port=9003` - The port where the debugger will run

## How to use in VS Code

- Setup the docker by using the repo as a reference.
- Copy the .vscode folder in your project and ensure the port and pathMappings are correct.
- Open debug toolbar in VS Code, Use `Ctrl + Shift + D` or press `ctrl + p` and type `view debug`.
- From the dropdown menu select `Listen for XDebug on Docker` if not already select and click the green play button
- That's it.
