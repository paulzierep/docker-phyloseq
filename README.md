# docker-phyloseq

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

* just run ` shiny::runGitHub`; then kill it with `timeout` (https://stackoverflow.com/questions/48740277/error-using-timeout-command-invalid-time-interval)

## Links 

* the tool wrapper: https://github.com/usegalaxy-eu/galaxy/pull/233
* the tool fork: https://github.com/paulzierep/shiny-phyloseq