FROM ipython/scipystack
MAINTAINER Alain Domissy <alaindomissy@gmail.com>

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
RUN echo deb http://cran.r-project.org/bin/linux/ubuntu trusty/ >> /etc/apt/sources.list
RUN apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get install -q -y \
  r-base \
  r-base-dev \
  r-cran-rcurl \
  libreadline-dev

#RUN echo 'options(repos=structure(c(CRAN="http://cran.rstudio.com")))' > ~/.Rprofile
#RUN mkdir -p ~/.R; echo "PKG_CXXFLAGS = '-std=c++11'" > ~/.R/Makevars
#RUN echo "install.packages(c('ggplot2', 'XML', 'plyr', 'randomForest', 'Hmisc', 'stringr', 'RColorBrewer', 'reshape', 'reshape2'))" | R --no-save
#RUN echo "install.packages(c('RCurl', 'devtools', 'dplyr'))" | R --no-save
#RUN echo "library(devtools); install_github('armstrtw/rzmq'); install_github('takluyver/IRdisplay'); install_github('takluyver/IRkernel'); IRkernel::installspec()" | R --no-save


RUN pip install rpy2


VOLUME /notebooks
WORKDIR /notebooks

EXPOSE 8888

# You can mount your own SSL certs as necessary here
ENV PEM_FILE /key.pem
# $PASSWORD will get `unset` within notebook.sh, turned into an IPython style hash
ENV PASSWORD Dont make this your default
ENV USE_HTTP 0

ADD notebook.sh /
RUN chmod u+x /notebook.sh

CMD ["/notebook.sh"]
