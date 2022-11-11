ARG TIDYVERSE_TAG

FROM rocker/tidyverse:${TIDYVERSE_TAG}

COPY rocker_scripts/install_python.sh /rocker_scripts/install_python.sh

RUN /rocker_scripts/install_python.sh

RUN install2.r --error --skipmissing --skipinstalled -n -1 mlflow tidymodels

ARG CONDA_VERSION
ARG CONDA_PATH

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh \
    && bash Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh -b -p ${CONDA_PATH} \
    && rm -f Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh 

ENV PATH="${CONDA_PATH}/bin:${PATH}"

RUN Rscript -e 'library(mlflow); install_mlflow()' 

RUN rm -rf /tmp/downloaded_packages && rm -rf /var/lib/apt/lists/* && strip /usr/local/lib/R/site-library/*/libs/*.so
