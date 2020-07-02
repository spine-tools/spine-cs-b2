using Revise
includet(joinpath("..", "init.jl"))

# Load Spine SOC evolution
# NOTE: To do this 1) open the Spine DB out databases 2) copy paste the values
# into the excel file "data/Spine_battery_storage_soc.csv"
df = CSV.read(joinpath(dataPath, "Spine_output_battery_storage_soc.csv"))
eSpineRepDays = df.Spine_rep_days
eSpineRolling = df.Spine_rolling_horizon

# Run GEPPR model as a check:
configFile = joinpath.(dataPath, "GEPPR_input_data", [
        "booleans.yaml",
        "parameters.yaml",
        "storage.yaml",
        "technologies_and_fuels_no_storage.yaml"
    ]
)
param = Dict(
    "modelType" => "Bram storage model",
)
gep = GenerationExpansionPlanningModel(configFile, param)
make_JuMP_model!(gep)
optimize_GEP_model!(gep)
# NOTE: "Spine storage model" should also work above, but I (Seb) had some
# troubles with it (coding bugs on my end, not intrinsic problems
# with the formulation I should say)

if GEPPR.get_model_type(gep) == "Bram storage model"
    eGEPPR = permutedims(
        dropdims(
            GEPPR.calculate_energy_content_evolution(gep).data,
            dims=(2,3)
        )[1,:,:],
        [2,1]
    )[:]
elseif GEPPR.get_model_type(gep) == "Spine storage model"
    eGEPPR = permutedims(
        dropdims(
           gep[:ltseap].data,
           dims=(2,3)
        )[1,:,:],
        [2,1]
    )[:]
end

# Plot simulations side by side
x = 1:7*2*24
plot(
    x ./ 24,
    hcat(eSpineRepDays, eGEPPR, eSpineRolling)[x,:],
    label = ["Spine Rep Days" "Validation model" "Spine rolling horizon"],
    ylabel = "Battery State of charge [GWh]",
    xlabel = "Days [-]"
)

# Save image
savefig(joinpath(dataPath, "battery_soc.png"))
