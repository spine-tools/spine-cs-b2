# NOTE: You shouldn't really have to run this
# This makes the Project.toml and Manifest.toml files

# Activate this environment
using Pkg
Pkg.activate(@__DIR__)

# Change package directory
ENV["JULIA_PKG_DEVDIR"] = joinpath(@__DIR__, ".julia")

# Add unregistered packages
# Do this once you've stopped developing
# NOTE: You need access to the VTT GitLab for this
# Pkg.add(PackageSpec(
#         url="git@gitlab.vtt.fi:spine/SpineInterface.jl.git",
#         rev="8c0414860e01222c8c30b7b8e0cfddb0b677f069"
#     )
# )
# Pkg.add(PackageSpec(
#         url="git@gitlab.vtt.fi:spine/model.git",
#         rev="4224cbe0ba3c4f0e9807323c761abe1fa2c8352a"
#     )
# )
# Pkg.add(PackageSpec(
#         url="https://gitlab.kuleuven.be/u0128861/GEPPR.jl.git",
#         rev="d7ef4a9cbb6c024df333984ae761f69ef04ec9a8"
#     )
# )

# For development, uncomment and run the lines below
# NOTE: You'll need to manually change branch after
Pkg.develop(PackageSpec(url="git@gitlab.vtt.fi:spine/SpineInterface.jl.git"))
Pkg.develop(abspath(@__DIR__, ".julia", "SpineOpt"))
Pkg.develop(PackageSpec(url="https://gitlab.kuleuven.be/u0128861/GEPPR.jl.git"))

# Instantiate the other packages (Project.toml file will make sure
# versions are correct)
Pkg.instantiate()
