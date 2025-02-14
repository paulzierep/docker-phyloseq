
#run locally so that the input can be patched

# Sys.setenv(SHINY_OUTPUT_DIR='/home/paul/Downloads')

# phyloseq_app <- shiny::runApp(appDir = "shiny-phyloseq",
#                                #launch.browser = FALSE, 
#                                port = 3838, 
#                                host = "0.0.0.0")


# test put function
# galaxy_url <- Sys.getenv("REMOTE_HOST")
# print(galaxy_url)
# galaxy_url <- Sys.getenv("API_KEY")
# print(galaxy_url)
# galaxy_url <- Sys.getenv("HISTORY_ID")
# print(galaxy_url)

# system("echo 'Hello from bash!' > /shiny_input/test.txt")
# system('put -p /shiny_input/test.txt')


phyloseq_app <- shiny::runGitHub(repo = "shiny-phyloseq",
                                 username = "paulzierep", 
                                 launch.browser = FALSE, 
                                 port = 3838, 
                                 host = "0.0.0.0",
                                 ref = "put_get_gx_it"
                                 )


phyloseq_app

