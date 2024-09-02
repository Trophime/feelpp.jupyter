# Jupyter Stack for CSMI PrePost Processing

## Build container


```docker build -t jupylab:pip -f Dockerfile-pip .```


[NOTE]
====
Check out group ownership of /dev/nvidia* on your host.
Adjust the docker build args to refletc this situation.

You can correct the docker container setup by running the following script as sudoers:

```
export VLGUSERS="vglusers"
export VGLUSERS_id=...

if [ $(getent group ${VGLUSERS_GID}) ]; then
   echo "${VGLUSERS} exists";
else
   sudo groupadd -g ${VGLUSERS_GID} ${VGLUSERS};
fi
sudo usermod -a -G ${VGLUSERS} feelpp
```

====

## Run container

### Use official image??

### Use build docker container

* To allow display from the container

```
xhost +local:root
```

* To start jupyter lab with nvidia:

```
docker run -it --rm --gpus all -e NVIDIA_DRIVER_CAPABILITIES=all  -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -p 8888:8888 --name jupylab jupylab:pip
```

* To start jupyter lab without nvidia support:

```
docker run -it --rm  --network=host -p 8888:8888 --name jupylab jupylab:pip
```

* Once you have stopped the container:

```
xhost +local:root
```

* From the host,

```chromium -incognito http://localhost:$ JUPYTER_PORT/lab?token=$JUPYTER_TOKEN```
```firefox --private-window http://localhost:$ JUPYTER_PORT/lab?token=$JUPYTER_TOKEN```

get JUPYTER_TOKEN and JUPYTER_PORT from the command line
example:

```
JupyterLab v4.2.5
/home/jovyan/jupyterlab-env/share/jupyter/labextensions
        trame-jupyter-extension v2.1.2 enabled OK (python, trame-jupyter-extension)
        jupyterlab_pygments v0.3.0 enabled OK (python, jupyterlab_pygments)
        @jupyter-widgets/jupyterlab-manager v5.0.13 enabled OK (python, jupyterlab_widgets)
        @jupyterhub/jupyter-server-proxy v4.3.0 enabled OK
        @jupyter-notebook/lab-extension v7.2.1 enabled OK

[I 2024-08-27 07:34:14.254 ServerApp] jupyter_lsp | extension was successfully linked.
[I 2024-08-27 07:34:14.254 ServerApp] jupyter_server_proxy | extension was successfully linked.
[I 2024-08-27 07:34:14.258 ServerApp] jupyter_server_terminals | extension was successfully linked.
[I 2024-08-27 07:34:14.263 ServerApp] jupyterlab | extension was successfully linked.
[I 2024-08-27 07:34:14.267 ServerApp] nbclassic | extension was successfully linked.
[I 2024-08-27 07:34:14.271 ServerApp] notebook | extension was successfully linked.
[I 2024-08-27 07:34:14.272 ServerApp] Writing Jupyter server cookie secret to /home/jovyan/.local/share/jupyter/runtime/jupyter_cookie_secret
[I 2024-08-27 07:34:14.478 ServerApp] notebook_shim | extension was successfully linked.
[I 2024-08-27 07:34:14.478 ServerApp] trame_jupyter_extension | extension was successfully linked.
[I 2024-08-27 07:34:14.495 ServerApp] notebook_shim | extension was successfully loaded.
[I 2024-08-27 07:34:14.497 ServerApp] jupyter_lsp | extension was successfully loaded.
[I 2024-08-27 07:34:14.506 ServerApp] jupyter_server_proxy | extension was successfully loaded.
[I 2024-08-27 07:34:14.506 ServerApp] jupyter_server_terminals | extension was successfully loaded.
[I 2024-08-27 07:34:14.508 LabApp] JupyterLab extension loaded from /home/jovyan/jupyterlab-env/lib/python3.10/site-packages/jupyterlab
[I 2024-08-27 07:34:14.508 LabApp] JupyterLab application directory is /home/jovyan/jupyterlab-env/share/jupyter/lab
[I 2024-08-27 07:34:14.509 LabApp] Extension Manager is 'pypi'.
[I 2024-08-27 07:34:14.560 ServerApp] jupyterlab | extension was successfully loaded.

  _   _          _      _
 | | | |_ __  __| |__ _| |_ ___
 | |_| | '_ \/ _` / _` |  _/ -_)
  \___/| .__/\__,_\__,_|\__\___|
       |_|
                                                                           
Read the migration plan to Notebook 7 to learn about the new features and the actions to take if you are using extensions.

https://jupyter-notebook.readthedocs.io/en/latest/migrate_to_notebook7.html

Please note that updating to Notebook 7 might break some of your extensions.

[I 2024-08-27 07:34:14.563 ServerApp] nbclassic | extension was successfully loaded.
[I 2024-08-27 07:34:14.567 ServerApp] notebook | extension was successfully loaded.
[I 2024-08-27 07:34:14.567 ServerApp] Registered trame-jupyter-extension server extension
[I 2024-08-27 07:34:14.567 ServerApp] trame_jupyter_extension | extension was successfully loaded.
[I 2024-08-27 07:34:14.568 ServerApp] Serving notebooks from local directory: /home/jovyan
[I 2024-08-27 07:34:14.568 ServerApp] Jupyter Server 2.14.2 is running at:
[I 2024-08-27 07:34:14.568 ServerApp] http://0.0.0:8888/lab?token=e8b7a9a4a935b92b2ba2f272f4e6c89acf5645bbb19b646f
[I 2024-08-27 07:34:14.568 ServerApp]     http://127.0.0.1:8888/lab?token=e8b7a9a4a935b92b2ba2f272f4e6c89acf5645bbb19b646f
[I 2024-08-27 07:34:14.568 ServerApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[W 2024-08-27 07:34:14.571 ServerApp] No web browser found: Error('could not locate runnable browser').
[C 2024-08-27 07:34:14.571 ServerApp] 
```

* To stop: stop the container or `ctrl-C` in the ...

* Connect to the running container:

```docker exec -it jupylab /bin/bash```

* Mount notebooks: `-v /some/host/folder/for/work:/home/jovyan/work`
* User setup at runtime

## References

* https://jupyter-docker-stacks.readthedocs.io/en/latest/using/common.html
* https://discourse.jupyter.org/t/jupyterlab-permissions-in-docker-compose/22796

## Voila apps
