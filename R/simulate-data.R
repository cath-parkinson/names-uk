simulate_data <- function(num_names) {
  
  num_girls <- ceiling(num_names/2)
  num_boys = num_names - num_girls
  
  gender <- rep(c(0, 1),
                c(num_boys, num_girls))

  child_names <- randomNames::randomNames(num_names,
                             gender = gender,
                             which.names = "first")
  
  simulated_data <- tibble::tibble(name = child_names,
                                   gender = gender,
                                   year = 2021L,
                                   count = rpois(num_names,
                                                 lambda = 48)) %>% 
    bind_rows(tibble::tibble(name = child_names,
                             gender = gender,
                             year = 2022L,
                             count = rpois(num_names,
                                           lambda = 49))) %>%
    bind_rows(tibble::tibble(name = child_names,
                             gender = gender,
                             year = 2023L,
                             count = rpois(num_names,
                                           lambda = 50))) %>%
    dplyr::mutate(gender = if_else(gender == 0,
                                   "Boy",
                                   "Girl"),
                  gender = factor(gender,
                                  levels = c("Girl",
                                             "Boy"))) %>% 
    dplyr::arrange(name,
                   year)
  
  return(simulated_data)

}