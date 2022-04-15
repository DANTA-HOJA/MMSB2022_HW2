using Plots
using DifferentialEquations
using ModelingToolkit
Plots.gr(lw=2, fmt=:png)

# Convenience functions
hill(x, k) = x / (x + k)
hill(x, k, n) = hill(x^n, k^n)
reducedmm(x, k) = x / k

@parameters v_0 v_m1 v_m2 v_m3 Km_1 Km_2 Km_3
@variables t S1(t) S2(t) S3(t) v1(t) v2(t) v3(t)
D = Differential(t)

eqsFull = [ v1 ~ v_m1 * hill(S1, Km_1),
            v2 ~ v_m2 * hill(S2, Km_2),
            v3 ~ v_m3 * hill(S3, Km_3),
            D(S1) ~ v_0 - v1,
            D(S2) ~ v1 - v2,
            D(S3) ~ v2 - v3]

@named fullsys = ODESystem(eqsFull)
fullSys = structural_simplify(fullsys)

params = [v_0 => 2, v_m1 => 9, v_m2 => 12, v_m3 => 15, Km_1 => 1.0, Km_2 => 0.4, Km_3 => 3.0]


# initial condition (s1, s2, s3) = (0.3, 0.2, 0.1)
u1 = [S1 => 0.3, S2 => 0.2, S3 => 0.1]
tend1 = 2.0
sol1 = solve(ODEProblem(fullSys, u1, tend1, params))

plot(sol1, ylims=(0.0, 0.8),
     title="starting @ (s1, s2, s3) = (0.3, 0.2, 0.1)",
     xlabel="Time (arbitrary units)",
     ylabel="Concentration (arbitrary units)")


# initial condition (s1, s2, s3) = (6, 4, 4)
u2 = [S1 => 6.0, S2 => 4.0, S3 => 4.0]
tend2 = 4.0
sol2 = solve(ODEProblem(fullSys, u2, tend2, params))

plot(sol2, ylims=(0.0, 6.0),
    title="starting @ (s1, s2, s3) = (6, 4, 4)",
    xlabel="Time (arbitrary units)",
    ylabel="Concentration (arbitrary units)")