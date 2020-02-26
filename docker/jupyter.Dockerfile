ARG BASE_CONTAINER=jupyter/scipy-notebook
FROM $BASE_CONTAINER

RUN pip install --upgrade pip

RUN pip -V

# Install Tensorflow
RUN pip install \
    'tensorflow==2.1.0' \
    'tfx' \
    'tensorflow_model_analysis==0.21.1' --ignore-installed PyYAML && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN jupyter nbextension enable --py widgetsnbextension --sys-prefix 
RUN jupyter nbextension install --py --symlink tensorflow_model_analysis --sys-prefix 
RUN jupyter nbextension enable --py tensorflow_model_analysis --sys-prefix

RUN jupyter serverextension list && \
    pip show tensorflow_model_analysis

# CMD ["jupyter", "notebook", "--ip='0.0.0.0'", "--NotebookApp.token=''", "--NotebookApp.password=''", "--port 8888", "--no-browser", "--allow-root"]
ENTRYPOINT ["jupyter", "notebook", "--ip=*", "--NotebookApp.token=''", "--NotebookApp.password=''", "--port=8001", "--no-browser", "--notebook-dir=/notebooks"]
# ENTRYPOINT ["/bin/bash"]