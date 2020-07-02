cd(@__DIR__)
using Pkg
Pkg.activate(@__DIR__)

# Set Python executable to current and re-build PyCall if necessary
ENV["PYTHON"] = Sys.which("python")
try
    Pkg.build("PyCall")
catch e
    if !isa(e, Pkg.Types.PkgError)
        throw(e)
    end
end

# Precompile everything
Pkg.API.precompile()

# Use packages
# using SpineInterface # SpineOpt uses SpineInterface anyway hence commented
using SpineOpt
using Dates # For debugging with the time slice tools
using CSV # Because is useful sometimes
using DataFrames
using GEPPR # My GEP model to check the results, can get rid of at end
using JuMP
using Plots
using AxisArrays
using DataStructures
using JSON
using PyCall

# Useful vars
dataPath = abspath(@__DIR__, "data")
spineitemsPath = joinpath(
    @__DIR__, "data", "case_study_b2", ".spinetoolbox", "items"
)
GEPPRDataPath = abspath(dataPath, "GEPPR_input_data")
