
phyloseq_app <- shiny::runGitHub(repo = "shiny-phyloseq",
                                 username = "paulzierep", 
                                 launch.browser = FALSE, 
                                 port = 3838, 
                                 host = "0.0.0.0",
                                 ref = "put_get_gx_it"
                                 )


phyloseq_app

