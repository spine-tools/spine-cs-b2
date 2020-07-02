using Revise
includet(joinpath("..", "init.jl"))

# Load the ordering variable
chronMatrix = Array(CSV.read(joinpath(dataPath, "ordering_32_days.csv")))
u = Array(CSV.read(joinpath(dataPath, "decision_32_days.csv"))[:,:periods][:])
chron = [
    first(u[findall(x -> x == 1, chronMatrix[i,:])])
    for i = 1:size(chronMatrix, 1)
]

# Create the mapping as an OrderedDict(t_start,t_end => [t_start,t_end])
model_start = DateTime(2017)
jsonDict = OrderedDict(
    "type" => "map",
    "index_type" => "date_time",
    "data" => []
)
for d = 1:365
    for h = 1:24
        push!(
            jsonDict["data"],
            [string(model_start + Day(d-1) + Hour(h-1)), OrderedDict(
                "type" => "map",
                "index_type" => "date_time",
                "data" => [
                    [string(model_start + Day(d-1) + Hour(h)), OrderedDict(
                        "type" => "map",
                        "index_type" => "str",
                        "data" => hcat(
                            [
                                "start",
                                string(model_start + Hour(h-1) + Day(chron[d]-1))
                            ],
                            [
                                "end",
                                string(model_start + Hour(h) + Day(chron[d]-1))
                            ]
                        )
                    )]
                ]
            )]
        )
    end
end
open(joinpath(@__DIR__, "..", "data", "timeslice_map.json"),"w") do f
    JSON.print(f, jsonDict)
end

# NOTE: I haven't automated writing the JSON string to the database yet
