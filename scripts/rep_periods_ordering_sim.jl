using Revise
includet(joinpath("..", "init.jl"))

db_url_in = joinpath(
    "sqlite:///$(spineitemsPath)", "case_study_b2", "case_study_b2.sqlite"
)
db_url_out = joinpath(
    "sqlite:///$(spineitemsPath)", "case_study_b2_out", "case_study_b2_out.sqlite"
)

m = SpineOpt.run_spinemodel(db_url_in, db_url_out; cleanup=false, log_level=3)
