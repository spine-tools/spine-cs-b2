using Revise
includet(joinpath("..", "init.jl"))

# NOTE: This script was used to make it easier to write the start and end times
# to the temporal blocks. These were written in manually in the database,
# though I suppose it would have been possible to import these parameters

# Load the representative periods and their weights
df = CSV.read(abspath(dataPath, "decision_32_days.csv"))
u = Array(df[:,:periods])[:]
w = Array(df[:,:weights])[:]

# Write the selected day, it's weight plus start and end times to .csv
start = DateTime(2017)
df = DataFrame(
    period = u,
    weight = w,
    start_time = start .+ Day.(u) .- Day(1),
    end_time = start .+ Day.(u)
)

CSV.write(joinpath(dataPath, "32_rep_days_for_Spine.csv"), df)
