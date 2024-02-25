# Function to plot chart of name frequency over time
# name_data: one row per name-gender-year combination, columns: name, gender, 
# year, count.
# names_to_plot: character vector of names to be included from the name column
# in name_data
# gender: optional gender to filter to ("Girl" or "Boy")
plot_name_freq_over_time <- function(name_data,
                                     names_to_plot,
                                     gender) {
  
  chart_data <- name_data %>% 
    dplyr::filter(name %in% names_to_plot)
  
  if(!missing(gender)) {
    chart_data <- chart_data %>% 
      filter(gender == {{ gender }})
  }
  
  chart_years <- chart_data %>% 
    distinct(year) %>% 
    pull(year)
  
  if(missing(gender)) {
  chart <- chart_data %>% 
    ggplot2::ggplot(aes(x = year,
                        y = count,
                        colour = interaction(name,
                                             gender,
                                             sep = ":")))
  colour_legend_title <- "Name : Gender"
  } else {
    chart <- chart_data %>% 
      ggplot2::ggplot(aes(x = year,
                          y = count,
                          colour = name))
    
    colour_legend_title <- "Name"
  }
  
  chart <- chart +
    ggplot2::geom_line() +
    ggplot2::geom_point() +
    ggplot2::scale_x_continuous(breaks = chart_years) +
    ggplot2::labs(x = "Year",
                  y = "Frequency",
                  colour = colour_legend_title) +
    ggplot2::theme_classic()
  
  return(chart)
  
}
