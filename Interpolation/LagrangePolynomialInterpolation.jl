using Plots
function LagrangePolynomialInterpolation(X::Array{Float64}, Y::Array{Float64}, Xq::Array{Float64}) 
    n = length(X)
    Yq = []
    for xq in Xq 
        P_xq = 0.0  # Initialize interpolated value for xq
        for i in 1:n
            # Initialize the Lagrange basis 
            L_i = 1.0
            for j in 1:n
                if i != j
                    # Compute the lagrange basis
                    L_i *= (xq - X[j]) / (X[i] - X[j])
                end
            end
            # Add the contribution of the i-th term to the total polynomial
            P_xq += L_i * Y[i]
        end
         # Store the interpolated value in Yq
         push!(Yq, P_xq)
    end
return Yq
end

# Example 1 
X = Float64[20, 40, 60, 80, 100]  # Speed in km/h
Y = Float64[0.08, 0.06, 0.05, 0.07, 0.09]  # Fuel consumption in liter/km 
# Estimate the fuel consumption at the speeds:
Xq = Float64[23, 35, 50, 65, 75, 90] # km/h 
Yq = LagrangePolynomialInterpolation(X, Y, Xq) 
# Plot the results 
plot(X, Y, label = "Original Data", seriestype=:scatter, linestyle=:solid, lw=2, color=:blue, marker=(:circle, 4))
plot!(Xq, Yq, label =" Interpolated Data", seriestype=:scatter, color=:red, marker=(:circle, 4))
xlabel!("Speed in (km/h")
ylabel!("Fuel Consumption in (liter/km)- Lagrange Interpolation")
savefig("Fuel Consumption Estimation - Lagrange Interpolation.png")