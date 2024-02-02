# Spine Case Study B2: Representative periods for storage

** This repository is archived and no longer maintained. You may run into issues.**

This is a Spine Toolbox project for ...

# Instructions for use

## Python environment

Python 3.7, pip 19.1 or higher and virtualenv package are required. Note: If your main Python environment is managed by conda, please install virtualenv using conda install virtualenv.

First create a Python virtual environment and activate it.
```
> virtualenv .venv
> .venv\Scripts\activate
```

On Linux, use `source .venv/bin/activate`.

## Install Python dependencies.

```
(.venv) > pip install -r requirements.txt
```

## Julia environment

Julia 1.3.1 is required.

Instantiate Julia environment with

```
(.venv) > julia .julia/init.jl
```

## Spine Toolbox

You should now be able to launch Spine Toolbox using

```
(.venv) > spinetoolbox
```

# Repository description

Data is contained in the `data` directory (who would have thought). The Spine DBs can be found in `data/case_study_b2/.spinetoolbox`. Scripts can be found in `scripts`(madness!). 

One apology - the selection and ordering of representative periods (read "days" in this case) was done with RepresentativeDaysFinder.jl, a Julia package in development by the Energy Systems Modeling at KU Leuven. It is not yet ready to be public. The period selection and ordering method however is independent of the energy system model. See the papers below for inspiration on how you could do this:

[1] B. van der Heijde, A. Vandermeulen, R. Salenbien, and L. Helsen, “Representative days selection for district energy system optimisation: a solar district heating system with seasonal storage,” Appl. Energy, vol. 248, no. February, pp. 79–94, 2019.

[2] D. A. Tejada-Arango, M. Domeshek, S. Wogrin, and E. Centeno, “Enhanced representative days and system states modeling for energy storage investment analysis,” IEEE Trans. Power Syst., vol. 33, no. 6, pp. 6534–6544, 2018. 

# Data description
* `GEPPR_input_data` - input data for the GEPPR validation model.
* `case_study_b2` - Spine Toolbox project folder (also contains the databases).
* `decision_32_days.csv` - Contains selection and weighting variables which are output of RepresentativeDaysFinder.jl package.
* `ordering_32_days.csv` - Contains ordering variable as output of RepresentativeDaysFinder.jl package.
* `32_rep_days_for_Spine.csv` - file created by `write_temporal_blocks_to_csv.jl`.
* `Elia_2017.csv` - time series data imported into the Spine DBs. Obtained from Elia TSO website.
* `timeslice_map.json` - JSON file created by `write_mapping_parameter_to_json_file.jl`.
* `Spine_output_battery_storage.csv` - file used to plot Battery state of charge in `compare_SOC_evolution.jl`. To update it, copy paste output of Battery node state from the Spine Output DBs into this.


# Script descriptions

* `write_mapping_parameter_to_json_file.jl` - Writes a parameter which maps the periods in the year to their representative counter part to a JSON file. You need to manually write this to the Spine DB (unless you script this yourself).  
* `write_temporal_blocks_to_csv.jl` - Writes start and end times of temporal blocks to .csv files.
* `rep_periods_ordering_sim` - Runs SpineModel with representative periods with energy storage arbitrage between representative periods. 
* `rolling_horizon_sim.jl` - Runs SpineModel using a 1 week rolling horizon
* `comparing_SOC_evolution.jl` - Compares the results from the representative periods simulation, rolling horizon simulation and also a validation model (you can find the model in `.julia/GEPPR`).

# Developing
If for whatever reason you would like to further develop this case study, you will need to run the following:
```
(.venv) julia create_julia_environment.jl
```



