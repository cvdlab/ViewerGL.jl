using Pkg

if lowercase(get(ENV, "CI", "false")) == "true"
  if Sys.islinux()
    let basepython = get(ENV, "PYTHON", "python3")
        envpath = joinpath(@__DIR__, "env")
        run(`virtualenv --python=$basepython $envpath`)

        # python = joinpath(envpath, "Scripts", "python.exe")
        python = joinpath(envpath, "bin", "python3")

        run(`$python -m pip install scipy`)

        ENV["PYTHON"] = python
        Pkg.build("PyCall")
    end
  end
end
