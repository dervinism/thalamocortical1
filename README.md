# thalamocortical1
Large-scale thalamocortical network model for simulating physiological and paroxysmal brain rhythms (4 Hz spike and wave discharges) described in the PhD thesis: Dervinis, Martynas 2016. Pathophysiological mechanisms of absence epilepsy: a computational modelling study. The thesis could be downloaded on the Cardiff university online research repository (ORCA): http://orca.cf.ac.uk/96981/

Language: Neuron.

The main file is init.hoc

To run the model in the serial manner, type in the terminal:
```
nrnivmodl && nrngui init.hoc
```
To run the model in a parallel manner (recommended), you have to set up Neuron to run with MPI (read more about this in the [Neuron documentation](https://nrn.readthedocs.io/en/latest/courses/mpi_parallelization.html)). Once set up, type in this line:
```
nrnivmodl && mpiexec -np 16 nrniv -mpi init.hoc
```

What's in different folders:
- full_model_parameters_not_set. This is the main folder containing the full model. However, the parameters are not set to run any particular simulation described in any of the PhD thesis figures. You have to adjust model parameters yourself based on descriptions in the thesis. In order to run it without the thalamus go to the file ThCxprocs.hoc and set variables isFO and isHO to zero:
```
isFO = 0
isHO = 0
```
- cortical_slow_osc. This folder contains a model producing the cortical slow oscillation.
- cortical_delta_osc. This folder contains a model producing the cortical delta oscillation. The oscillation frequency is increased from slow to a delta range by changing the parameter on line 226 in the file Cx3cell.hoc from
```
g_pas = 0.0000273 - 0.0000125
```
to
```
g_pas = 0.0000273 - 0.0000253
```
