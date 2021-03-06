#!/bin/bash
# statistical analysis of the plot data and generation of plotable data
# for a number of Ns independent simulations
# a new directory will be generated, where the eval. data is stored.
# The form of the new directory is
# "eval_data_avg_Ns_{no_seeds}_sg_{gseed}_ss_{sseed}_t_{t_start}_{t_end}/"
# ignore "RuntimeWarning: invalid value encountered in true_divide"
# parameters can be adjusted in detail in
# "gen_plot_data.py" under "ANALYSIS PARAMETERS"
# in there, one needs to choose, which of the time indices
# of the stored data shall be evaluated by setting
# the arrays "time_ind" (for scalar fields) and
# "time_ind_moments" (for moment analysis)
# additionally, one can choose which fields are plotted,
# which volumes are analyzed for particle spectra etc.
# the generated data can be plotted with "plot_results_MA.py".
# In there, a configuration must be added in the parameter lists indicated
# and later on chosen by setting SIM_N (see "plot_results_MA.py")
# adjust the number of OMP threads for numpy
# and threads available to numba per process

# basic parameter setup in this file:
#storage_path="/Users/bohrer/sim_data_cloudMP/" # sim data is in here
storage_path="/vols/fs1/work/bohrer/sim_data_cloudMP/" # sim data is in here

gseed=1001 # first SIP generation seed
sseed=1001 # first simulation seed
no_sim=50 # number of seeds

# load the basic grid time t_grid.
# The setting of t_grid is just for plotting of the grid
# and has no influence on the analysis of the simulation runs,
# for which one needs to set t_start and t_end below
t_grid=10800 # in s
t_start=7200 # in s
t_end=10800 # in s

no_cells_x=75
no_cells_z=75
solute_type="AS"
no_spcm0=26 # number of super particles first mode
no_spcm1=38 # number of super particles 2nd mode
no_col_per_adv=2 # # number of collisions steps per advection step
sim_type="with_collisions" # possible: "spin_up", "with_collisions", "wo_collisions"

export OMP_NUM_THREADS=8
export NUMBA_NUM_THREADS=16
echo $gseed $sseed
python3 generate_plot_data.py $storage_path $no_cells_x $no_cells_z $solute_type $no_spcm0 $no_spcm1 $no_sim ${gseed} ${sseed} $sim_type $t_grid $t_start $t_end $no_col_per_adv &
