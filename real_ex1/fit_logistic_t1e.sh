#!/bin/bash

#Set the name of the job. This will be the first part of the error/output filename.
#$ -N fit_logistic_t1e

#Set the shell that should be used to run the job.
#$ -S /bin/bash

#Set the current working directory as the location for the error and output files.
#(Will show up as .e and .o files)
#$ -cwd

#Select the queue to run in
#$ -q all.q

#$ -l mem_256G

#Select the number of slots the job will use
#$ -pe smp 20

#Send e-mail at beginning/end/suspension of job
#$ -m be

#E-mail address to send to
#$ -M brandon-lebeau@uiowa.edu

#####Begin Compute Work#####
#Load R Module
module load R/3.5.1

#R script file
Rscript ~/real_ex1/R/fit_t1e_mod.r 


