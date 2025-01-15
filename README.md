# devcontainer-python

A devcontainer with node(pnpm) and python(uv).

## Usage

In a devcontainer you will need

```
  "containerEnv": {
    "CONTAINER_WORKSPACE": "${containerWorkspaceFolder}"
  },
  "mounts": [
    "source=opt_uv,target=/opt/uv,type=volume",
  ],
```

This is mainly so that `uv` may set its cache in a volume and to be able have a reference to the workspace folder.
