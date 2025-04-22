# docker-phyloseq

Docker set-up for a modified phyloseq shiny app, that integrates Galaxy put/get function into the Docker file.

## TODO

* set-up dev container [x]
* test mulled container for the app [x]
* fix all download buttons [x]
* move close button globally
* try to use put / get function of Galaxy [x]
* Explain how to run locally in Docs
* Allow app to run without input

## Updates

* Point `shiny::runGitHub` to a fork (https://github.com/paulzierep/shiny-phyloseq) where `BiocManager` is only installed if required. Thus starting the app without installations (since all packages are installed in the container) which should allow galaxy to run the app.

## Test image locally

```
docker build . -t 'shiny-phyloseq'
docker run -p 3838:3838 shiny-phyloseq
docker run -v /home/paul/git/my-repositories/shiny-phyloseq/data:/shiny_input -p 3838:3838 shiny-phyloseq #with the hacked galaxy input
```

## Uplodad

* Create a release in github
* The CI will push it to quay.io

Test with:

```
docker pull quay.io/paulzierep/shinyphyloseq:0.1
```

Access on http://127.0.0.1:3838/

## Ideas

### Get all dependency in the container without knowing the app

* just run ` shiny::runGitHub`; then kill it with `timeout` (https://stackoverflow.com/questions/48740277/error-using-timeout-command-invalid-time-interval)

### Use mulled biocontainers instead of R for container building

The R build had some issues (did not close / did not load data), the same app did run without issue in a
conda env. Let's try to reproduce it.
Using a PR here: https://github.com/BioContainers/multi-package-containers/edit/master/combinations/hash.tsv

## Check the packages

Run in the container

```
installed.packages()
```


## Links 

* the tool wrapper: https://github.com/usegalaxy-eu/galaxy/pull/233
* the tool fork: https://github.com/paulzierep/shiny-phyloseq

# Wrapper

## Test wrapper locally

Get Galaxy !

```
GALAXY_PATH=~/git/galaxy # modify
mv $GALAXY_PATH/config/galaxy.yml.interactivetools $GALAXY_PATH/config/galaxy.yml
mv $GALAXY_PATH/config/job_conf.yml.interactivetools $GALAXY_PATH/config/job_conf.yml
mv $GALAXY_PATH/config/tool_conf.xml.sample $GALAXY_PATH/config/tool_conf.xml #add interactive tools
```

## Test app locally

```
git clone https://github.com/paulzierep/shiny-phyloseq
mamba create -n shiny -c conda-forge -c bioconda r-shiny bioconductor-phyloseq r-biocmanager r-curl
mamba activate shiny
export SHINY_OUTPUT_DIR=/home/paul/Downloads
Rscript start.R
```

# Allow to use put / get in the shiny app

* Check https://github.com/bgruening/docker-jupyter-notebook/blob/master/Dockerfile
* https://github.com/bgruening/galaxy_ie_helpers/blob/master/galaxy_ie_helpers/__init__.py

## Add phylosq app to Galaxy

ln -s /home/paul/git/tools-dev/pyloseq-itx/docker-phyloseq/interactivetool_phyloseq.xml $GALAXY_PATH/tools/interactive/interactivetool_phyloseq.xml
cp /home/paul/git/tools-dev/pyloseq-itx/docker-phyloseq/interactivetool_phyloseq.xml $GALAXY_PATH/tools/interactive/interactivetool_phyloseq.xml

# Todo check why put cannot connect locally ?

See: https://github.com/bgruening/galaxy_ie_helpers/issues/14
* Get ip with ifconfig
* Requires login