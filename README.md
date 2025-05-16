# docker-phyloseq

Docker set-up for a modified phyloseq shiny app, that integrates Galaxy put/get function into the Docker file.

### Steps to Integrate a Shiny Phyloseq App with Galaxy

1. **Create or Fork a Shiny App**

   * Start by forking or creating a Shiny app similar to [shiny-phyloseq](https://github.com/paulzierep/shiny-phyloseq).

2. **(Optional) Implement Galaxy Data Exchange (put/get)**

   * Add custom `put` and `get` functions to interact with Galaxy histories.
   * Example implementation (on a separate branch):
     [https://github.com/paulzierep/shiny-phyloseq/blob/7461c8f372d458e82c59e24da298ac79b32904f6/panels/panel-server-ordination.R#L161-L169](https://github.com/paulzierep/shiny-phyloseq/blob/7461c8f372d458e82c59e24da298ac79b32904f6/panels/panel-server-ordination.R#L161-L169)

3. **Create a Dockerfile**

   * Set up a Dockerfile that includes all required dependencies.
   * Use this as a reference:
     [https://github.com/paulzierep/docker-phyloseq/blob/main/Dockerfile](https://github.com/paulzierep/docker-phyloseq/blob/main/Dockerfile)

4. **(Optional) Include put/get Dependencies in Dockerfile**

   * If you're using the Galaxy data exchange functions, ensure the Dockerfile supports them.
   * See example:
     [https://github.com/paulzierep/docker-phyloseq/blob/fafc0ee37573f5d1ebe6ad67c2228dc240ef94b5/Dockerfile#L17](https://github.com/paulzierep/docker-phyloseq/blob/fafc0ee37573f5d1ebe6ad67c2228dc240ef94b5/Dockerfile#L17)

5. **Configure Runtime Behavior**

   * Ensure the app launches automatically on container start.
   * Example setup script:
     [https://github.com/paulzierep/docker-phyloseq/blob/main/app\_setup.R](https://github.com/paulzierep/docker-phyloseq/blob/main/app_setup.R)

6. **Test the Docker Container Locally**

   * Run the container on your local machine and verify the Shiny app launches and functions correctly.

7. **Deploy the Docker Container**

   * Use CI/CD (e.g. GitHub Actions) to build and deploy the container.
   * Example workflow:
     [https://github.com/paulzierep/docker-phyloseq/blob/main/.github/workflows/release.yml](https://github.com/paulzierep/docker-phyloseq/blob/main/.github/workflows/release.yml)

8. **Write a Galaxy Tool Wrapper**

   * Create a wrapper for your interactive tool.
   * Reference example:
     [https://github.com/paulzierep/docker-phyloseq/blob/main/interactivetool\_phyloseq.xml](https://github.com/paulzierep/docker-phyloseq/blob/main/interactivetool_phyloseq.xml)
   * **Note:** `environment_variables` in the XML are only necessary if using the Galaxy `put/get` integration.

9. **Test the Galaxy Wrapper Locally**

   * Use a local Galaxy instance and interactive tools configuration to verify the integration and functionality. (See Test wrapper locally)

10. **Submit a Pull Request**

    * Contribute your wrapper to the Galaxy code base (or a specific server setup).
    * Example target (Europe server):
      [https://github.com/usegalaxy-eu/galaxy/blob/release\_24.2\_europe/tools/interactive/interactivetool\_phyloseq.xml](https://github.com/usegalaxy-eu/galaxy/blob/release_24.2_europe/tools/interactive/interactivetool_phyloseq.xml)
    * Note: Interactive tools are deployed **directly via GitHub**, not via the Toolshed.

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