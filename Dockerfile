ARG TIDYVERSE_TAG

FROM rocker/tidyverse:${TIDYVERSE_TAG}

COPY rocker_scripts/install_python.sh /rocker_scripts/install_python.sh

RUN /rocker_scripts/install_python.sh

RUN install2.r --error --skipmissing --skipinstalled -n -1 mlflow tidymodels

RUN Rscript -e 'library(reticulate); install_miniconda(); library(mlflow); install_mlflow()' 

RUN rm -rf /tmp/downloaded_packages && rm -rf /var/lib/apt/lists/* && strip /usr/local/lib/R/site-library/*/libs/*.so
