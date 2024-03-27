# will do things here

# did once the cloning of the repo in here, but it is because i want to configure the ports and all

# or use the ellipsis..

# not clear exactly at first glance what and how needs to be provided, but some example datasets are in

# consider putting the files to run this whole in the app folder we would grab from the repo?

# definition of outputs for this to be clarified..

phyloseq_app <- shiny::runGitHub(repo = "shiny-phyloseq",
                                 username = "paulzierep", 
                                 launch.browser = FALSE, 
                                 port = 3838, 
                                 host = "0.0.0.0")

phyloseq_app

# run locally so that the input can be patched
# phyloseq_app <- shiny::runApp(appDir = "shiny-phyloseq",
#                               launch.browser = FALSE, 
#                               port = 3838, 
#                               host = "0.0.0.0")

# phyloseq_app