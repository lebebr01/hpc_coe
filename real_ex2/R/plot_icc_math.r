# Setup -----
# packages
library(dplyr)
library(ggplot2)

filenames <- list.files(path = "~/hpc_coe/real_ex2/data", 
                        pattern = "icc_info_math_nose",
                        full.names = TRUE)

for(j in seq_along(filenames)) {
  
  # load data
  # called icc_info_math_df
  load(filenames[j])
  
  
  # get unique condtions for this block_items
  conditions <- distinct(icc_info_math_df, model, block_items, sample_size, item)
  
  # plot ICCs ----
  for(i in 1:nrow(conditions)) {
    
    icc_data <- semi_join(icc_info_math_df, conditions[i, ])
    
    label_title <- paste(conditions[i, ], collapse = " - ")
    
    p <- ggplot(icc_data, aes(x = theta1, y = icc)) + 
      geom_line(aes(group = repl), size = 1, alpha = .4) + 
      scale_y_continuous(limits = c(0, 1), expand = c(0, 0), 
                         breaks = seq(0, 1, by = .2)) + 
      geom_smooth(size = 1.5, se = FALSE) +
      xlab("Ability") + 
      ylab("Probability") + 
      labs(title = label_title) +
      theme_bw()
    ggsave(filename = paste0(paste(conditions[i, ], collapse = "_"), ".png"), plot = p,
           path = "~/hpc_coe/real_ex2/images/icc",
           width = 6, height = 4, dpi = 320, units = 'in')
  }
  
  # Plot TCCs and Information -----
  conditions <- distinct(icc_info_math_df, model, block_items, sample_size)
  
  
  for(i in 1:nrow(conditions)) {
    
    tcc_data <- semi_join(icc_info_math_df, conditions[i, ])
    
    tcc_info <- tcc_data %>% 
      distinct(theta1, tcc, test_info, repl, model, block_items, sample_size) %>%
      mutate(see = 1 / sqrt(test_info))
    
    label_title <- paste(conditions[i, ], collapse = " - ")
    
    p <- ggplot(tcc_info, aes(x = theta1, y = tcc)) + 
      geom_line(aes(group = repl), size = 1, alpha = .4) +  
      geom_smooth(size = 1.5, se = FALSE) +
      xlab("Ability") + 
      ylab("Model Implied Number Correct") + 
      labs(title = label_title) +
      theme_bw()
    ggsave(filename = paste0(paste(conditions[i, ], collapse = "_"), ".png"), plot = p,
           path = "~/hpc_coe/real_ex2/images/tcc",
           width = 6, height = 4, dpi = 320, units = 'in')
    
    # Information
    p <- ggplot(tcc_info, aes(x = theta1, y = test_info)) + 
      geom_line(aes(group = repl), size = 1, alpha = .4) + 
      geom_smooth(size = 1.5, se = FALSE) +
      xlab("Ability") + 
      ylab("Information") + 
      labs(title = label_title) +
      theme_bw()
    ggsave(filename = paste0(paste(conditions[i, ], collapse = "_"), ".png"), plot = p,
           path = "~/hpc_coe/real_ex2/images/information",
           width = 6, height = 4, dpi = 320, units = 'in')
    
    # SEE
    p <- ggplot(tcc_info, aes(x = theta1, y = see)) + 
      geom_line(aes(group = repl), size = 1, alpha = .4) +  
      geom_smooth(size = 1.5, se = FALSE) +
      xlab("Ability") + 
      ylab("Standard Error of the Estimate") + 
      labs(title = label_title) +
      theme_bw()
    ggsave(filename = paste0(paste(conditions[i, ], collapse = "_"), ".png"), plot = p,
           path = "~/hpc_coe/real_ex2/images/see",
           width = 6, height = 4, dpi = 320, units = 'in')
    
  }
  
}

