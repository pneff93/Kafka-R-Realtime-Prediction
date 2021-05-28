FROM trestletech/plumber

# Install dependencies
RUN apt-get update --allow-releaseinfo-change && apt-get install -y \
    liblapack-dev \
    libpq-dev

# # Install R packages
# RUN R -e "install.packages(c('tidyr', 'dplyr', 'magrittr', 'httr', 'jsonlite'), \
# repos = 'http://cran.us.r-project.org')"

# Add API
COPY ./R/r2.R /r2.R

# Make port available
EXPOSE 8000

# Entrypoint
ENTRYPOINT ["R", "-e", \
"widelong <- plumber::plumb('r2.R'); \
widelong$run(host = '0.0.0.0', port= 8000)"]

CMD ["/r2.R"]