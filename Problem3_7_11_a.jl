using Plots
Plots.gr(lw=2)

K = [500, 1000, 2000]
Kt = 1000
Kr = 1

function dimer_binding(K, Kt, Kr, x)

    x_Kt = x/Kt
    x_Kr = x/Kr

    Y_Numerator = K*x_Kt*(1+x_Kt)+x_Kr*(1+x_Kr)
    Y_denominator = K*(1+x_Kt)^2+(1+x_Kr)^2

    Y = Y_Numerator/Y_denominator

    return Y # (x = x, Y = Y)
end

p1 = plot(title = "Problem 3.7.11 (a)", size=(600,400),
     xlims=(0.0, 200.0), ylims=(0.0, 1.0),
     xlabel= "oxygen concentration",
     ylabel= "fractional saturation",
     ) # 開一個空的圖，assign to p1


plot!(p1, x->dimer_binding(K[1], Kt, Kr, x), 0.0, 200.0, label="K = 500", legend=:bottomright) # para3 => x_min, para4 => x_max
plot!(p1, x->dimer_binding(K[2], Kt, Kr, x), 0.0, 200.0, label="K = 1000", legend=:bottomright) # para3 => x_min, para4 => x_max
plot!(p1, x->dimer_binding(K[3], Kt, Kr, x), 0.0, 200.0, label="K = 2000", legend=:bottomright) # para3 => x_min, para4 => x_max